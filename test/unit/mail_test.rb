require 'test_helper'

class MailTest < ActiveSupport::TestCase

  test "Mail creates instance" do
    assert_instance_of Mail, Mail.create(
      :number => 12345,
      :subject => "Hi",
      :from => "a@b.cd",
      :time => Time.now,
      :in_reply_to => nil,
      :body => "Hello, world!"
    )
  end
end
