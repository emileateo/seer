require 'test_helper'

class ExtensionControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get extension_show_url
    assert_response :success
  end

end
