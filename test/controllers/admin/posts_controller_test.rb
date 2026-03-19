require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    login_user(@admin)
  end
  
  test "should get index" do
    get admin_posts_url
    assert_response :success
  end
end
