require "net/http"
require "json"

class Course < ApplicationRecord
  validates :server_id, presence: true, uniqueness: true
  validates :name, presence: true

  SCRAPER_URL = URI("http://localhost:3000/scraper/courses")

  def self.sync!
    response = Net::HTTP.get(SCRAPER_URL)
    courses = JSON.parse(response)

    courses.each do |course|
      find_or_initialize_by(server_id: course["valore"]).tap do |c|
        c.name = course["label"]
        c.save!
      end
    end
  end
end
