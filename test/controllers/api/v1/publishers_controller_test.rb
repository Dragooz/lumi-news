require "test_helper"

class Api::V1::PublishersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_publishers_index_url
    assert_response :success
  end
end
