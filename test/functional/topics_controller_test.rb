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

      request.env["HTTP_REFERER"] = root_url
      put :update, id: @topic.to_param,
                   topic: @topic.attributes.update(subject: "hi")

      assert_not_equal orig, Topic.find(@topic.id).subject
      assert_redirected_to root_path
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
