require "net/http"
require "uri"
require "json"

class ScraperController < ApplicationController
  def courses
    url = URI("https://agendastudentiunipd.easystaff.it/combo.php?sw=ec_&aa=2024&page=attivita")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Accept"] = "application/javascript, */*; q=0.01"
    request["Referer"] = "https://agendastudentiunipd.easystaff.it/index.php?view=easycourse&_lang=it&include=attivita"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
    request["X-Requested-With"] = "XMLHttpRequest"
    # request['Cookie'] = '...' # Optional, if not required

    response = http.request(request)

    body = response.body

    # Strip leading JS assignment
    if body.start_with?("var elenco_attivita =")
      json_string = body.sub(/^var elenco_attivita =\s*/, "").sub(/;$/, "")
      parsed = JSON.parse(json_string)
      render json: parsed
    else
      render json: { error: "Unexpected response format" }, status: 500
    end
  rescue => e
    render json: { error: e.message }, status: 500
  end

  def lessons
    url = URI("https://agendastudentiunipd.easystaff.it/grid_call.php")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8"
    request["Accept"] = "application/json, text/javascript, */*; q=0.01"
    request["Referer"] = "https://agendastudentiunipd.easystaff.it/index.php"
    request["Origin"] = "https://agendastudentiunipd.easystaff.it"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
    request["X-Requested-With"] = "XMLHttpRequest"
    # request['Cookie'] = 'PHPSESSID=...; AWSALB=...; AWSALBCORS=...' # optional, test without

    # This payload matches your `--data-raw` in form-encoded structure
    payload = {
      "view" => "easycourse",
      "form-type" => "attivita",
      "include" => "attivita",
      "anno" => "2024",
      "attivita[]" => [ "EC767926", "EC767933" ], # Add or replace with dynamic values
      "visualizzazione_orario" => "cal",
      "periodo_didattico" => "",
      "date" => "11-05-2025",
      "_lang" => "en",
      "list" => "",
      "week_grid_type" => "-1",
      "ar_codes_" => "",
      "ar_select_" => "",
      "col_cells" => "0",
      "empty_box" => "0",
      "only_grid" => "0",
      "highlighted_date" => "0",
      "all_events" => "0",
      "faculty_group" => "0",
      "txtcurr" => ""
    }

    request.body = URI.encode_www_form(payload)

    response = http.request(request)
    render json: JSON.parse(response.body)
  rescue => e
    render json: { error: e.message }, status: 500
  end
end
