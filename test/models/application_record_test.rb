require "test_helper"

class ApplicationRecordTest < ActiveSupport::TestCase
  test "ApplicationRecord inherits from ActiveRecord::Base" do
    assert_equal ActiveRecord::Base, ApplicationRecord.superclass
  end

  test "ApplicationRecord is an abstract class" do
    assert ApplicationRecord.abstract_class?
  end

  test "ApplicationRecord is a primary abstract class" do
    assert ApplicationRecord.primary_abstract_class
  end

  test "subclass is not abstract by default" do
    subclass = Class.new(ApplicationRecord) do
      self.table_name = "dummy_models"
    end

    refute subclass.abstract_class?
  ensure
    Object.send(:remove_const, subclass.name) if subclass && subclass.name
  end

  test "subclass inherits from ApplicationRecord" do
    subclass = Class.new(ApplicationRecord) do
      self.table_name = "dummy_models"
    end

    assert_equal ApplicationRecord, subclass.superclass
  ensure
    Object.send(:remove_const, subclass.name) if subclass && subclass.name
  end

  test "ApplicationRecord cannot be instantiated directly" do
    assert_raises(NotImplementedError) do
      ApplicationRecord.new
    end
  end

  test "subclass can be instantiated" do
    subclass = Class.new(ApplicationRecord) do
      self.table_name = "active_storage_blobs"
    end

    instance = subclass.new
    assert_instance_of subclass, instance
    refute instance.persisted?
  ensure
    Object.send(:remove_const, subclass.name) if subclass && subclass.name
  end
end
