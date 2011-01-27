require 'test_helper'

class TranslationRequestsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  context "Routing" do
    should "should route to TranslationRequestsController" do
      assert_recognizes({controller: "translation_requests", action: "create", post_id: "1" },
                        {path: '/posts/1/translation_request', method: "post"})

      assert_recognizes({controller: "translation_requests", action: "destroy", post_id: "1" },
                        {path: '/posts/1/translation_request', method: "delete"})

      assert_raise ActionController::RoutingError do
        assert_recognizes({},
                          {path: '/posts/1/translation_request', method: "get"})
      end
 
    end
  end

  context "logged in user" do
    should "post create" do
      login_as users(:two)
      assert_difference "TranslationRequest.count", 1 do
        post :create, post_id: @post.number.to_s, format: "js"
        assert_response :success
        assert_match /location/, @response.body
      end
    end

    should "get destroy" do
      login_as users(:one)
      assert_difference "TranslationRequest.count", -1 do
        delete :destroy, post_id: @post.number.to_s, format: "json"
        assert_response :success
        assert_match /location/, @response.body
      end
    end
  end

  context "guest user" do
    should "not get create" do
      logout
      assert_no_difference "TranslationRequest.count" do
        post :create, :post_id => @post.number.to_s
      end
    end

    should "not get destroy" do
      logout
      assert_no_difference "TranslationRequest.count" do
        delete :destroy, :post_id => @post.number.to_s
      end
    end
  end

  context "when not found" do
    should "return 404" do
      logout
      assert_no_difference "TranslationRequest.count" do
        delete :destroy, :post_id => 0
        assert_response 404
      end
    end
  end
end
