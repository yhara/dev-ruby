# coding: utf-8
require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "Post creates instance" do
    assert_instance_of Post, Post.create(
      :number => 12345,
      :subject => "Hi",
      :from => "a@b.cd",
      :time => Time.now,
      :parent => nil,
      :body => "Hello, world!"
    )
  end

  test "Posts should form trees" do
    m1 = Fabricate(:post)
      m2 = Fabricate(:post, parent: m1)
        m3 = Fabricate(:post, parent: m2)
      m4 = Fabricate(:post, parent: m1)
    m5 = Fabricate(:post)

    assert_equal({m1 => {m2 => {m3 => {}}, m4 => {}}},
      m1.subtree.arrange)
  end

  context "class method" do
    should "find recent requested posts" do
      Post.destroy_all
      m1, m2, m3, m4, m5 = *Array.new(5){ Fabricate(:post) }
      TranslationRequest.create(post_id: m4.id, user: users(:one))
      TranslationRequest.create(post_id: m2.id, user: users(:two))

      assert_equal [m2, m4], Post.recent_requested(5)
    end

    should "find top requested posts" do
      Post.destroy_all
      m1, m2, m3, m4, m5 = *Array.new(5){ Fabricate(:post) }
      TranslationRequest.create(post_id: m4.id, user: users(:one))
      TranslationRequest.create(post_id: m2.id, user: users(:one))
      TranslationRequest.create(post_id: m2.id, user: users(:two))

      assert_equal [m2, m4], Post.recent_requested(5)
    end

    should "find recently translated posts" do
      Post.destroy_all
      Translation.destroy_all
      m1, m2, m3, m4, m5 = *Array.new(5){ Fabricate(:post) }
      Translation.create(post: m2, user: users(:one), body: "-")
      Translation.create(post: m4, user: users(:one), body: "-")
      Translation.create(post: m2, user: users(:two), body: "-")

      assert_equal [m2, m4], Post.recent_translated(5)
    end
  end

end
