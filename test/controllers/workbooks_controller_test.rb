require 'test_helper'

class WorkbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get workbooks_new_url
    assert_response :success
  end

  test "should get index" do
    get workbooks_index_url
    assert_response :success
  end

end
