require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  should "create instance" do
    post = Fabricate(:post)

    topic = Topic.new
    topic.post_id = post.id
    topic.subject = post.subject
    topic.last_update = post.time

    assert topic.valid?, "should be valid"
    assert topic.save, "should be saved"
  end

  context "creating posts" do
    should "create topic automatically" do
      m1 = m4 = m5 = nil
      assert_difference "Topic.count", +2 do
        m1 = Fabricate(:post, subject: "M1")
          m2 = Fabricate(:post, parent: m1, time: Time.now)
            m3 = Fabricate(:post, parent: m2, time: Time.now + 1)
          m4 = Fabricate(:post, parent: m1, time: Time.now + 2)
        m5 = Fabricate(:post, subject: "M5")
      end

      t1 = Topic.where(post_id: m1.id).first
      assert_equal "M1", t1.subject
      assert_equal m4.time, t1.last_update

      t5 = Topic.where(post_id: m5.id).first
      assert_equal "M5", t5.subject
      assert_equal m5.time, t5.last_update
    end
  end
end
