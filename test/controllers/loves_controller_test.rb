require 'test_helper'

class LovesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get loves_show_url
    assert_response :success
  end

end
