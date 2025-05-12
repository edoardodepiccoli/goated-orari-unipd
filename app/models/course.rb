require "net/http"
require "uri"
require "json"

class Course < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :attendances
  has_many :users, through: :attendances

  has_many :lessons

  scope :with_users, -> { joins(:users).distinct }

  def self.fetch_courses
    url = URI("https://agendastudentiunipd.easystaff.it/combo.php?sw=ec_&aa=2024&page=attivita")
    response = Net::HTTP.get(url)
    json_string = response.sub(/^var elenco_attivita =\s*/, "").sub(/;$/, "")
    JSON.parse(json_string)
  end

  def self.sync!
    courses = fetch_courses
    courses.each do |course|
      find_or_initialize_by(code: course["valore"]).tap do |c|
        c.name = course["label"]
        c.save!
      end
    end
  end

  def fetch_lessons(date)
    url = URI("https://agendastudentiunipd.easystaff.it/grid_call.php")
    Rails.logger.info("Fetching lessons for course: #{code}")
    payload = {
      "view" => "easycourse",
      "form-type" => "attivita",
      "include" => "attivita",
      "anno" => "2024",
      "attivita[]" => [code],
      "visualizzazione_orario" => "cal",
      "periodo_didattico" => "",
      "date" => date,
      "_lang" => "en",
      "week_grid_type" => "-1",
      "col_cells" => "0",
      "empty_box" => "0",
      "only_grid" => "0",
      "highlighted_date" => "0",
      "all_events" => "0",
      "faculty_group" => "0",
      "txtcurr" => "",
    }

    response = Net::HTTP.post_form(url, payload)
    JSON.parse(response.body)["celle"]
  end

  def create_lessons
    return if lessons.any?

    lessons.delete_all

    current_week_data = fetch_lessons(Time.now.strftime("%d-%m-%Y"))
    next_week_data = fetch_lessons((Time.now + 7.days).strftime("%d-%m-%Y"))
    lessons_data = current_week_data + next_week_data

    return if lessons_data.empty?

    lessons_data.each do |lesson|
      Lesson.create!(
        server_id: lesson["id"],
        teacher: lesson["docente"],
        room: lesson["aula"],
        date: lesson["data"],
        start_time: lesson["ora_inizio"],
        end_time: lesson["ora_fine"],
        course: self,
      )
    end

    self.touch
  end
end
