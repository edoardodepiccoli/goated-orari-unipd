require "test_helper"

class ScraperControllerTest < ActionDispatch::IntegrationTest
  test "should get courses" do
    get scraper_courses_url
    assert_response :success
  end
end
