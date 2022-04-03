require 'test_helper'

class PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get payment_view_url
    assert_response :success
  end

end
