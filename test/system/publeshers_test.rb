require "application_system_test_case"

class PubleshersTest < ApplicationSystemTestCase
  setup do
    @publesher = publeshers(:one)
  end

  test "visiting the index" do
    visit publeshers_url
    assert_selector "h1", text: "Publeshers"
  end

  test "creating a Publesher" do
    visit publeshers_url
    click_on "New Publesher"

    fill_in "Publesher", with: @publesher.publesher
    click_on "Create Publesher"

    assert_text "Publesher was successfully created"
    click_on "Back"
  end

  test "updating a Publesher" do
    visit publeshers_url
    click_on "Edit", match: :first

    fill_in "Publesher", with: @publesher.publesher
    click_on "Update Publesher"

    assert_text "Publesher was successfully updated"
    click_on "Back"
  end

  test "destroying a Publesher" do
    visit publeshers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Publesher was successfully destroyed"
  end
end
