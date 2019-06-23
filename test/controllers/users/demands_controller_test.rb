require 'test_helper'

class Users::DemandsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_demands_new_url
    assert_response :success
  end

  test "should get edit" do
    get users_demands_edit_url
    assert_response :success
  end

end
