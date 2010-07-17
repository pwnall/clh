require 'test_helper'

class GeocodeFetchesControllerTest < ActionController::TestCase
  setup do
    @geocode_fetch = geocode_fetches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geocode_fetches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geocode_fetch" do
    assert_difference('GeocodeFetch.count') do
      post :create, :geocode_fetch => @geocode_fetch.attributes
    end

    assert_redirected_to geocode_fetch_path(assigns(:geocode_fetch))
  end

  test "should show geocode_fetch" do
    get :show, :id => @geocode_fetch.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @geocode_fetch.to_param
    assert_response :success
  end

  test "should update geocode_fetch" do
    put :update, :id => @geocode_fetch.to_param, :geocode_fetch => @geocode_fetch.attributes
    assert_redirected_to geocode_fetch_path(assigns(:geocode_fetch))
  end

  test "should destroy geocode_fetch" do
    assert_difference('GeocodeFetch.count', -1) do
      delete :destroy, :id => @geocode_fetch.to_param
    end

    assert_redirected_to geocode_fetches_path
  end
end
