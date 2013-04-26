require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { age_from: @event.age_from, age_to: @event.age_to, cancelled: @event.cancelled, city_id: @event.city_id, creason: @event.creason, emails: @event.emails, finish_at: @event.finish_at, gender: @event.gender, group_id: @event.group_id, info: @event.info, location_id: @event.location_id, max_part: @event.max_part, mode: @event.mode, private: @event.private, skill_from: @event.skill_from, skill_to: @event.skill_to, sport_id: @event.sport_id, start_at: @event.start_at, type_id: @event.type_id }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { age_from: @event.age_from, age_to: @event.age_to, cancelled: @event.cancelled, city_id: @event.city_id, creason: @event.creason, emails: @event.emails, finish_at: @event.finish_at, gender: @event.gender, group_id: @event.group_id, info: @event.info, location_id: @event.location_id, max_part: @event.max_part, mode: @event.mode, private: @event.private, skill_from: @event.skill_from, skill_to: @event.skill_to, sport_id: @event.sport_id, start_at: @event.start_at, type_id: @event.type_id }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
