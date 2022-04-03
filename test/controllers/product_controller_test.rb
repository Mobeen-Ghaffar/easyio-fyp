require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get product_add_url
    assert_response :success
  end

end
