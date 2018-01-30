require 'test_helper'

class CreplyControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get creply_create_url
    assert_response :success
  end

  test "should get destroy" do
    get creply_destroy_url
    assert_response :success
  end

end
