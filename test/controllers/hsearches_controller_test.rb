require 'test_helper'

class HsearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get result" do
    get hsearches_result_url
    assert_response :success
  end

end
