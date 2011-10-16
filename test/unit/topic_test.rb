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
      t = Time.now
      m1 = m4 = m5 = nil
      assert_difference "Topic.count", +2 do
        m1 = Fabricate(:post, subject: "M1", time: t)
          m2 = Fabricate(:post, parent: m1, time: t+1)
            m3 = Fabricate(:post, parent: m2, time: t+2)
          m4 = Fabricate(:post, parent: m1, time: t+3)
        m5 = Fabricate(:post, subject: "M5", time: t+4)
      end

      t1 = Topic.where(post_id: m1.id).first
      assert_equal "M1", t1.subject
      assert_equal m4.time, t1.last_update

      t5 = Topic.where(post_id: m5.id).first
      assert_equal "M5", t5.subject
      assert_equal m5.time, t5.last_update
    end
  end

  context "#merge_to" do
    should "merge a tree into another" do
      t = Time.now
      m0 = Fabricate(:post, subject: "M1", time: t)
        m1 = Fabricate(:post, parent: m0, time: t+1)
          m2 = Fabricate(:post, parent: m1, time: t+9)
      m3 = Fabricate(:post, subject: "M5", time: t+4)
        m4 = Fabricate(:post, parent: m3, time: t+3)

      #Post.roots.each{|root| p root.subtree.arrange}
      old_topic = m0.topic
      old_topic.merge_to(m4)

      # Old topic should be deleted
      assert Topic.where(id: old_topic.id).empty?

      assert_equal({m3 => {m4 => {m0 => {m1 => {m2 => {}}}}}},
        m3.subtree.arrange)
      assert_equal m2.time, m3.topic.last_update
    end
  end
end
