require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "ApplicationController inherits from ActionController::Base" do
    assert_equal ActionController::Base, ApplicationController.superclass
  end

  test "ApplicationController is a class" do
    assert_kind_of Class, ApplicationController
  end

  test "ApplicationController::allow_browser method exists" do
    assert ApplicationController.respond_to?(:allow_browser)
  end

  test "ApplicationController::stale_when_importmap_changes method exists" do
    assert ApplicationController.respond_to?(:stale_when_importmap_changes)
  end

  test "subclass inherits ApplicationController configuration" do
    subclass = Class.new(ApplicationController) do
      def index
        render plain: "test"
      end
    end

    assert_equal ApplicationController, subclass.superclass
    assert subclass.respond_to?(:allow_browser)
    assert subclass.respond_to?(:stale_when_importmap_changes)
  ensure
    Object.send(:remove_const, subclass.name) if subclass && subclass.name
  end

  test "ApplicationController responds to standard controller methods" do
    assert ApplicationController.instance_methods.include?(:render)
    assert ApplicationController.instance_methods.include?(:redirect_to)
  end

  test "ApplicationController includes standard controller concerns" do
    assert_includes ApplicationController.included_modules, ActionController::BasicImplicitRender
  end

  test "ApplicationController can handle requests" do
    test_controller = Class.new(ApplicationController) do
      def index
        render plain: "OK"
      end
    end

    Rails.application.routes.draw do
      get "test_index", to: test_controller.action(:index)
    end

    get "/test_index"
    assert_response :success
    assert_equal "OK", response.body
  ensure
    Rails.application.routes.clear!
  end
end
