require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status" do
    assert_difference('Status.count') do
      post :create, status: { acc_profit: @status.acc_profit, charm: @status.charm, e_no: @status.e_no, elegance: @status.elegance, exp: @status.exp, funds: @status.funds, generate_no: @status.generate_no, knowledge: @status.knowledge, perseverance: @status.perseverance, repute: @status.repute, result_no: @status.result_no, rp: @status.rp, smile: @status.smile, tact: @status.tact }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status
    assert_response :success
  end

  test "should update status" do
    patch :update, id: @status, status: { acc_profit: @status.acc_profit, charm: @status.charm, e_no: @status.e_no, elegance: @status.elegance, exp: @status.exp, funds: @status.funds, generate_no: @status.generate_no, knowledge: @status.knowledge, perseverance: @status.perseverance, repute: @status.repute, result_no: @status.result_no, rp: @status.rp, smile: @status.smile, tact: @status.tact }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
