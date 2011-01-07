require 'test_helper'

class Mail
  def inspect; "#<Mail:#{self.number}>"; end
end

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

  test "Mails should form trees" do
    m1 = Fabricate(:mail)
      m2 = Fabricate(:mail, parent: m1)
        m3 = Fabricate(:mail, parent: m2)
      m4 = Fabricate(:mail, parent: m1)
    m5 = Fabricate(:mail)

    assert_equal({m1 => {m2 => {m3 => {}}, m4 => {}}},
      m1.subtree.arrange)
  end
end
