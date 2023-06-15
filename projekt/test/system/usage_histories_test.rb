require "application_system_test_case"

class UsageHistoriesTest < ApplicationSystemTestCase
  setup do
    @usage_history = usage_histories(:one)
  end

  test "visiting the index" do
    visit usage_histories_url
    assert_selector "h1", text: "Usage histories"
  end

  test "should create usage history" do
    visit usage_histories_url
    click_on "New usage history"

    fill_in "When used", with: @usage_history.when_used
    click_on "Create Usage history"

    assert_text "Usage history was successfully created"
    click_on "Back"
  end

  test "should update Usage history" do
    visit usage_history_url(@usage_history)
    click_on "Edit this usage history", match: :first

    fill_in "When used", with: @usage_history.when_used
    click_on "Update Usage history"

    assert_text "Usage history was successfully updated"
    click_on "Back"
  end

  test "should destroy Usage history" do
    visit usage_history_url(@usage_history)
    click_on "Destroy this usage history", match: :first

    assert_text "Usage history was successfully destroyed"
  end
end
