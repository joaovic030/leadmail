require 'test_helper'

class LeadControllerTest < ActionDispatch::IntegrationTest
  test "should get receive_message" do
    get lead_receive_message_url
    assert_response :success
  end

end
