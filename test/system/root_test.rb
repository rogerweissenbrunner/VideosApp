require "application_system_test_case"

class RootsTest < ApplicationSystemTestCase
  test "visiting the site" do
    visit "/"
    assert_content "Rails"
  end
end
