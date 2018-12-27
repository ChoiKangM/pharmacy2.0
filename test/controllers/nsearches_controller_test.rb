require 'test_helper'

class NsearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get result" do
    get nsearches_result_url
    assert_response :success
  end

end
