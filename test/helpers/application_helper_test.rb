require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "ApplicationHelper is a module" do
    assert_kind_of Module, ApplicationHelper
  end

  test "ApplicationHelper can be included" do
    test_class = Class.new do
      include ApplicationHelper
    end
    assert_includes test_class.included_modules, ApplicationHelper
  end

  test "ApplicationHelper methods are available in view context" do
    assert_kind_of ActionView::TestCase, self
    assert_includes self.class.included_modules, ApplicationHelper
  end
end
