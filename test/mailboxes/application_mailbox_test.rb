require "test_helper"

class ApplicationMailboxTest < ActiveSupport::TestCase
  test "ApplicationMailbox inherits from ActionMailbox::Base" do
    assert_equal ActionMailbox::Base, ApplicationMailbox.superclass
  end

  test "ApplicationMailbox is a class" do
    assert_kind_of Class, ApplicationMailbox
  end

  test "ApplicationMailbox routing method exists" do
    assert ApplicationMailbox.respond_to?(:routing)
  end

  test "ApplicationMailbox responds to process method" do
    assert ApplicationMailbox.instance_methods.include?(:process)
  end
end
