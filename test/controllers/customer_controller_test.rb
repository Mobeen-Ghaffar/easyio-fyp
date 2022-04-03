require 'test_helper'

class CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get customer_add_url
    assert_response :success
  end

end
