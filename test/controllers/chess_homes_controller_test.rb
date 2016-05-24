require 'test_helper'

class ChessHomesControllerTest < ActionController::TestCase
  setup do
    @chess_home = chess_homes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chess_homes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chess_home" do
    assert_difference('ChessHome.count') do
      post :create, chess_home: {  }
    end

    assert_redirected_to chess_home_path(assigns(:chess_home))
  end

  test "should show chess_home" do
    get :show, id: @chess_home
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chess_home
    assert_response :success
  end

  test "should update chess_home" do
    patch :update, id: @chess_home, chess_home: {  }
    assert_redirected_to chess_home_path(assigns(:chess_home))
  end

  test "should destroy chess_home" do
    assert_difference('ChessHome.count', -1) do
      delete :destroy, id: @chess_home
    end

    assert_redirected_to chess_homes_path
  end
end
