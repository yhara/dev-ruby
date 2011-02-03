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

end
