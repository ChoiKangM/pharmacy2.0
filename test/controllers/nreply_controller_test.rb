require 'test_helper'

class NreplyControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get nreply_create_url
    assert_response :success
  end

  test "should get destroy" do
    get nreply_destroy_url
    assert_response :success
  end

end
