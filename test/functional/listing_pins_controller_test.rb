require 'test_helper'

class ListingPinsControllerTest < ActionController::TestCase
  setup do
    @listing_pin = listing_pins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listing_pins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listing_pin" do
    assert_difference('ListingPin.count') do
      post :create, :listing_pin => @listing_pin.attributes
    end

    assert_redirected_to listing_pin_path(assigns(:listing_pin))
  end

  test "should show listing_pin" do
    get :show, :id => @listing_pin.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @listing_pin.to_param
    assert_response :success
  end

  test "should update listing_pin" do
    put :update, :id => @listing_pin.to_param, :listing_pin => @listing_pin.attributes
    assert_redirected_to listing_pin_path(assigns(:listing_pin))
  end

  test "should destroy listing_pin" do
    assert_difference('ListingPin.count', -1) do
      delete :destroy, :id => @listing_pin.to_param
    end

    assert_redirected_to listing_pins_path
  end
end
