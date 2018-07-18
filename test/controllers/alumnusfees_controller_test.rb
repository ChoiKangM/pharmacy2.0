require 'test_helper'

class AlumnusfeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alumnusfees_index_url
    assert_response :success
  end

  test "should get show" do
    get alumnusfees_show_url
    assert_response :success
  end

  test "should get new" do
    get alumnusfees_new_url
    assert_response :success
  end

  test "should get edit" do
    get alumnusfees_edit_url
    assert_response :success
  end

end
