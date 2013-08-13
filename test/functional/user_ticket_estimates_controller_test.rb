require 'test_helper'

class UserTicketEstimatesControllerTest < ActionController::TestCase
  setup do
    @user_ticket_estimate = user_ticket_estimates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ticket_estimates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_ticket_estimate" do
    assert_difference('UserTicketEstimate.count') do
      post :create, user_ticket_estimate: {  }
    end

    assert_redirected_to user_ticket_estimate_path(assigns(:user_ticket_estimate))
  end

  test "should show user_ticket_estimate" do
    get :show, id: @user_ticket_estimate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_ticket_estimate
    assert_response :success
  end

  test "should update user_ticket_estimate" do
    put :update, id: @user_ticket_estimate, user_ticket_estimate: {  }
    assert_redirected_to user_ticket_estimate_path(assigns(:user_ticket_estimate))
  end

  test "should destroy user_ticket_estimate" do
    assert_difference('UserTicketEstimate.count', -1) do
      delete :destroy, id: @user_ticket_estimate
    end

    assert_redirected_to user_ticket_estimates_path
  end
end
