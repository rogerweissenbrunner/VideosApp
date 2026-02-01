require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "ApplicationMailer inherits from ActionMailer::Base" do
    assert_equal ActionMailer::Base, ApplicationMailer.superclass
  end

  test "default from address is configured" do
    assert_equal "from@example.com", ApplicationMailer.default[:from]
  end

  test "default layout is configured" do
    assert_equal "mailer", ApplicationMailer._layout
  end

  test "can create and deliver mail" do
    email = ApplicationMailer.new.mail(
      subject: "Test Subject",
      to: "test@example.com",
      body: "Test body"
    )
    assert_equal ["from@example.com"], email.from
    assert_equal ["test@example.com"], email.to
    assert_equal "Test Subject", email.subject
  end

  test "mail uses mailer layout" do
    email = ApplicationMailer.new.mail(
      subject: "Test",
      to: "test@example.com",
      body: "Test"
    )
    assert_equal "mailer", ApplicationMailer._layout
  end
end
