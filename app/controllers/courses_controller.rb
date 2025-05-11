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
    @course = Course.find(params[:id])
    current_user.courses << @course
    redirect_to courses_path
  end
end
