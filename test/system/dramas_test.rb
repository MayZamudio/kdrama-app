require "application_system_test_case"

class DramasTest < ApplicationSystemTestCase
  setup do
    @drama = dramas(:one)
  end

  test "visiting the index" do
    visit dramas_url
    assert_selector "h1", text: "Dramas"
  end

  test "should create drama" do
    visit dramas_url
    click_on "New drama"

    fill_in "Air date", with: @drama.air_date
    fill_in "Backdrop", with: @drama.backdrop
    fill_in "Overview", with: @drama.overview
    fill_in "Poster", with: @drama.poster
    fill_in "Rating", with: @drama.rating
    fill_in "Title", with: @drama.title
    click_on "Create Drama"

    assert_text "Drama was successfully created"
    click_on "Back"
  end

  test "should update Drama" do
    visit drama_url(@drama)
    click_on "Edit this drama", match: :first

    fill_in "Air date", with: @drama.air_date
    fill_in "Backdrop", with: @drama.backdrop
    fill_in "Overview", with: @drama.overview
    fill_in "Poster", with: @drama.poster
    fill_in "Rating", with: @drama.rating
    fill_in "Title", with: @drama.title
    click_on "Update Drama"

    assert_text "Drama was successfully updated"
    click_on "Back"
  end

  test "should destroy Drama" do
    visit drama_url(@drama)
    click_on "Destroy this drama", match: :first

    assert_text "Drama was successfully destroyed"
  end
end
