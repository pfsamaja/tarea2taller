require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should render" do
    post :buscar, tag: 'hola', access_token: '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    assert_response :success
   end
end
