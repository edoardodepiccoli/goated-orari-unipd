class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search].present?
      search_term = params[:search].downcase
      search_terms = search_term.split(" ")
      @courses = Course.where(
        search_terms.map { |term| "LOWER(name) LIKE ?" }.join(" AND "),
        *search_terms.map { |term| "%#{term}%" }
      )
    else
      @courses = []
    end
  end

  # this is not a normal post route
  # it simply adds the course to the user's courses
  def create
    @course = Course.find(params[:course_id])

    if current_user.courses.include?(@course)
      redirect_to courses_path, alert: "Hai già aggiunto questo corso"
      return
    end

    Rails.logger.info("Course: #{@course.inspect}")

    unless @course.users.any? || @course.lessons.any?
      begin
        # fetch lessons
        lessons = @course.fetch_lessons
        Rails.logger.info("Lessons: #{lessons}")

        if lessons.any?
          # build lessons
          lessons.each do |lesson|
            Lesson.create!(
              server_id: lesson["id"],
              teacher: lesson["docente"],
              room: lesson["aula"],
              start_time: lesson["ora_inizio"],
              end_time: lesson["ora_fine"],
              course: @course,
            )
          end
        else
          flash[:alert] = "Nessuna lezione trovata per questo corso"
        end
      rescue => e
        Rails.logger.error("Error fetching lessons: #{e.message}")
        redirect_to courses_path, alert: "Errore durante il recupero delle lezioni: #{e.message}"
        return
      end
    end

    current_user.courses << @course
    redirect_to courses_path, notice: "Corso aggiunto"
  end
end
