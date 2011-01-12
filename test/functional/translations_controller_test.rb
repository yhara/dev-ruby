require 'test_helper'

class TranslationsControllerTest < ActionController::TestCase
  setup do
    @translation = translations(:one)
    @mail = @translation.mail
  end

  test "should get new" do
    get :new, :mail_id => @mail.number.to_s
    assert_response :success
  end

  test "should create translation" do
    assert_difference('Translation.count') do
      post :create, :mail_id => @mail.number.to_s,
                    :translation => @translation.attributes
    end

    assert_redirected_to mail_path(assigns(:translation).mail)
  end
end
