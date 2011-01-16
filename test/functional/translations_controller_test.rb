require 'test_helper'

class TranslationsControllerTest < ActionController::TestCase
  setup do
    @translation = translations(:one)
    @post = @translation.post
  end

  test "should get new" do
    get :new, :post_id => @post.number.to_s
    assert_response :success
  end

  test "should create translation" do
    assert_difference('Translation.count') do
      post :create, :post_id => @post.number.to_s,
                    :translation => @translation.attributes
    end

    assert_redirected_to post_path(assigns(:translation).post)
  end
end
