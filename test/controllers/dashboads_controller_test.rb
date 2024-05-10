require "test_helper"

class DashboadsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dashboads_show_url
    assert_response :success
  end
end
