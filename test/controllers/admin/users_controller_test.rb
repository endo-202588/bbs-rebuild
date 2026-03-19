require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:general)
    @admin = users(:admin) # fixtureでadmin用意している前提

    # ログイン（方法は環境に合わせる）
    login_user(@admin)
  end

  test "should get index" do
    get admin_users_url
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_user_url(@user)
    assert_response :success
  end

  test "should get update" do
    patch admin_user_url(@user), params: {
      user: { display_name: "変更後" }
    }
    
    assert_redirected_to admin_users_url
  end

  test "should get destroy" do
    assert_difference("User.count", -1) do
      delete admin_user_url(@user)
    end

    assert_redirected_to admin_users_url
  end
end
