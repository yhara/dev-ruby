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

  test "Mail.trees creates trees of mails" do
    m1 = Fabricate(:mail)
      m2 = Fabricate(:mail, :in_reply_to => m1.number)
        m3 = Fabricate(:mail, :in_reply_to => m2.number)
      m4 = Fabricate(:mail, :in_reply_to => m1.number)
    m5 = Fabricate(:mail)

    #trees = Mail.trees([m1, m2, m3, m4, m5])
  end
end
