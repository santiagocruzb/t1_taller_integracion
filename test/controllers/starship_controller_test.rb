require 'test_helper'

class StarshipControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get starship_show_url
    assert_response :success
  end

end
