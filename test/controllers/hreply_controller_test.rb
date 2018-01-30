require 'test_helper'

class HreplyControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get hreply_create_url
    assert_response :success
  end

  test "should get destroy" do
    get hreply_destroy_url
    assert_response :success
  end

end
