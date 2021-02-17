require 'test_helper'

class MyportfoliosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get myportfolios_index_url
    assert_response :success
  end

end
