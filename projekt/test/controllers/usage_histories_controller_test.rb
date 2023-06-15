require "test_helper"

class UsageHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usage_history = usage_histories(:one)
  end

  test "should get index" do
    get usage_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_usage_history_url
    assert_response :success
  end

  test "should create usage_history" do
    assert_difference("UsageHistory.count") do
      post usage_histories_url, params: { usage_history: { when_used: @usage_history.when_used } }
    end

    assert_redirected_to usage_history_url(UsageHistory.last)
  end

  test "should show usage_history" do
    get usage_history_url(@usage_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_usage_history_url(@usage_history)
    assert_response :success
  end

  test "should update usage_history" do
    patch usage_history_url(@usage_history), params: { usage_history: { when_used: @usage_history.when_used } }
    assert_redirected_to usage_history_url(@usage_history)
  end

  test "should destroy usage_history" do
    assert_difference("UsageHistory.count", -1) do
      delete usage_history_url(@usage_history)
    end

    assert_redirected_to usage_histories_url
  end
end
