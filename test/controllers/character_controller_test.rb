require 'test_helper'

class CharacterControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get character_show_url
    assert_response :success
  end

end
