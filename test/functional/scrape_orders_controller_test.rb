require 'test_helper'

class ScrapeOrdersControllerTest < ActionController::TestCase
  setup do
    @scrape_order = scrape_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scrape_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scrape_order" do
    assert_difference('ScrapeOrder.count') do
      post :create, :scrape_order => @scrape_order.attributes
    end

    assert_redirected_to scrape_order_path(assigns(:scrape_order))
  end

  test "should show scrape_order" do
    get :show, :id => @scrape_order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @scrape_order.to_param
    assert_response :success
  end

  test "should update scrape_order" do
    put :update, :id => @scrape_order.to_param, :scrape_order => @scrape_order.attributes
    assert_redirected_to scrape_order_path(assigns(:scrape_order))
  end

  test "should destroy scrape_order" do
    assert_difference('ScrapeOrder.count', -1) do
      delete :destroy, :id => @scrape_order.to_param
    end

    assert_redirected_to scrape_orders_path
  end
end
