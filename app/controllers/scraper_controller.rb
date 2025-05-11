require "net/http"
require "uri"
require "json"

class ScraperController < ApplicationController
  def courses
    url = URI("https://agendastudentiunipd.easystaff.it/combo.php?sw=ec_&aa=2024&page=attivita")

    response = Net::HTTP.get(url)
    json_string = response.sub(/^var elenco_attivita =\s*/, "").sub(/;$/, "")
    render json: JSON.parse(json_string)
  end

  def lessons
    course_ids = params[:ids] || []

    url = URI("https://agendastudentiunipd.easystaff.it/grid_call.php")

    payload = {
      "view" => "easycourse",
      "form-type" => "attivita",
      "include" => "attivita",
      "anno" => "2024",
      "attivita[]" => course_ids,
      "visualizzazione_orario" => "cal",
      "periodo_didattico" => "",
      "date" => "11-05-2025",
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
    render json: JSON.parse(response.body)
  end
end
