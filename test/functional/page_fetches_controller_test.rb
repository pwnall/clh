require 'test_helper'

class PageFetchesControllerTest < ActionController::TestCase
  setup do
    @page_fetch = page_fetches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_fetches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_fetch" do
    assert_difference('PageFetch.count') do
      post :create, :page_fetch => @page_fetch.attributes
    end

    assert_redirected_to page_fetch_path(assigns(:page_fetch))
  end

  test "should show page_fetch" do
    get :show, :id => @page_fetch.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @page_fetch.to_param
    assert_response :success
  end

  test "should update page_fetch" do
    put :update, :id => @page_fetch.to_param, :page_fetch => @page_fetch.attributes
    assert_redirected_to page_fetch_path(assigns(:page_fetch))
  end

  test "should destroy page_fetch" do
    assert_difference('PageFetch.count', -1) do
      delete :destroy, :id => @page_fetch.to_param
    end

    assert_redirected_to page_fetches_path
  end
end
