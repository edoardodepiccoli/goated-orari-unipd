class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:destroy]

  def index
    if params[:search].present?
      search_term = params[:search].downcase
      search_terms = search_term.split(" ")
      @courses = Course.where(
        search_terms.map { |term| "LOWER(name) LIKE ?" }.join(" AND "),
        *search_terms.map { |term| "%#{term}%" }
      )
    else
      # @courses = Course.order("RANDOM()").limit(10)
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

    unless @course.lessons.any?
      @course.create_lessons
    end

    unless @course.exams.any?
      @course.create_exams
    end

    current_user.courses << @course
    redirect_to courses_path, notice: "Corso aggiunto"
  end

  def destroy
    if current_user.courses.include?(@course)
      current_user.courses.delete(@course)
      redirect_to courses_path, notice: "Corso rimosso"
    else
      redirect_to courses_path, alert: "Hai già rimosso questo corso"
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
