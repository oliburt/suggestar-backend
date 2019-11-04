require 'test_helper'

class Api::V1::ListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_listings_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_listings_create_url
    assert_response :success
  end

end
