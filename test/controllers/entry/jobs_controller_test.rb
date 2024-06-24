require "test_helper"

class Entry::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entry_jobs_index_url
    assert_response :success
  end

  test "should get show" do
    get entry_jobs_show_url
    assert_response :success
  end
end
