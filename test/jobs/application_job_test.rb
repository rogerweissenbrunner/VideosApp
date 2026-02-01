require "test_helper"

module JobExecutionTracker
  @tracker = {}
  
  def self.clear
    @tracker.clear
  end
  
  def self.increment(key)
    @tracker[key] ||= 0
    @tracker[key] += 1
  end
  
  def self.count(key)
    @tracker[key] || 0
  end
end

class ApplicationJobTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  class RetryTestJob < ApplicationJob
    def perform(tracker_key)
      JobExecutionTracker.increment(tracker_key)
      raise ActiveRecord::Deadlocked if JobExecutionTracker.count(tracker_key) < 3
    end
  end

  class DiscardTestJob < ApplicationJob
    def perform(tracker_key)
      JobExecutionTracker.increment(tracker_key)
      original = ActiveRecord::RecordNotFound.new("Record not found")
      error = ActiveJob::DeserializationError.allocate
      error.instance_variable_set(:@original_exception, original)
      raise error
    end
  end

  setup do
    JobExecutionTracker.clear
  end

  test "ApplicationJob class is properly configured" do
    assert_equal ActiveJob::Base, ApplicationJob.superclass
    assert ApplicationJob < ActiveJob::Base
  end

  test "ApplicationJob is configured with retry_on for ActiveRecord::Deadlocked" do
    tracker_key = "retry_config_test_#{SecureRandom.hex(4)}"
    RetryTestJob.perform_later(tracker_key)
    perform_enqueued_jobs
    execution_count = JobExecutionTracker.count(tracker_key)
    assert execution_count >= 1, "Job should have been executed at least once"
    perform_enqueued_jobs
    final_count = JobExecutionTracker.count(tracker_key)
    assert final_count > 1, "Job should have been retried due to retry_on configuration. Final count: #{final_count}"
  end

  test "ApplicationJob is configured with discard_on for ActiveJob::DeserializationError" do
    tracker_key = "discard_config_test_#{SecureRandom.hex(4)}"
    DiscardTestJob.perform_later(tracker_key)
    perform_enqueued_jobs
    assert_equal 1, JobExecutionTracker.count(tracker_key), "Job should be discarded after first execution"
    assert_no_enqueued_jobs
  end

  test "should retry on ActiveRecord::Deadlocked" do
    tracker_key = "retry_test_#{SecureRandom.hex(4)}"
    RetryTestJob.perform_later(tracker_key)
    perform_enqueued_jobs
    assert JobExecutionTracker.count(tracker_key) >= 1, "Job should have been executed at least once"
  end

  test "should discard on ActiveJob::DeserializationError" do
    tracker_key = "discard_test_#{SecureRandom.hex(4)}"
    DiscardTestJob.perform_later(tracker_key)
    perform_enqueued_jobs
    assert_equal 1, JobExecutionTracker.count(tracker_key), "Job should execute once and then be discarded"
    assert_no_enqueued_jobs
  end
end
