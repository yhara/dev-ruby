require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = topics(:one)
  end

  context "login user" do
    should "get edit" do
      login_as users(:one)
      get :edit, id: @topic.to_param
      assert_response :success
    end

    should "update subject of the topic" do
      login_as users(:one)

      orig = @topic.subject

      put :update, id: @topic.to_param,
                   topic: @topic.attributes.update(subject: "hi")

      assert_not_equal orig, Topic.find(@topic.id).subject
      assert_redirected_to posts_path
    end

    should "update subject and redirect to original page" do
      login_as users(:one)

      session[:from] = post_path(@topic.root)

      put :update, id: @topic.to_param,
                   topic: @topic.attributes.update(subject: "hi")

      assert_redirected_to post_path(@topic.root)
    end
  end

  context "guest user" do
    should "not update subject of the topic" do
      logout
      orig = @topic.subject

      put :update, id: @topic.to_param,
                   topic: @topic.attributes.update(subject: "hi")

      assert_equal orig, Topic.find(@topic.id).subject
    end
  end

end
