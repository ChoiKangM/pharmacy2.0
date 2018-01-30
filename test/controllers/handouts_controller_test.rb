require 'test_helper'

class HandoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get handouts_index_url
    assert_response :success
  end

  test "should get show" do
    get handouts_show_url
    assert_response :success
  end

  test "should get new" do
    get handouts_new_url
    assert_response :success
  end

  test "should get edit" do
    get handouts_edit_url
    assert_response :success
  end

end
