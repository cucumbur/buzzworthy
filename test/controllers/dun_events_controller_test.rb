require 'test_helper'

class DunEventsControllerTest < ActionController::TestCase
  setup do
    @dun_event = dun_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dun_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dun_event" do
    assert_difference('DunEvent.count') do
      post :create, dun_event: { description: @dun_event.description, name: @dun_event.name }
    end

    assert_redirected_to dun_event_path(assigns(:dun_event))
  end

  test "should show dun_event" do
    get :show, id: @dun_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dun_event
    assert_response :success
  end

  test "should update dun_event" do
    patch :update, id: @dun_event, dun_event: { description: @dun_event.description, name: @dun_event.name }
    assert_redirected_to dun_event_path(assigns(:dun_event))
  end

  test "should destroy dun_event" do
    assert_difference('DunEvent.count', -1) do
      delete :destroy, id: @dun_event
    end

    assert_redirected_to dun_events_path
  end
end
