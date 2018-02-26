require 'test_helper'

class MakePublicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get make_publics_index_url
    assert_response :success
  end

  test "should get show" do
    get make_publics_show_url
    assert_response :success
  end

  test "should get new" do
    get make_publics_new_url
    assert_response :success
  end

  test "should get edit" do
    get make_publics_edit_url
    assert_response :success
  end

end
