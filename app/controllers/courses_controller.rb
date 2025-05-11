class CoursesController < ApplicationController
  def index
    @courses = Course.all
    render json: @courses
  end

  def sync
    Course.sync!
    render json: { message: "Courses synced successfully" }
  end
end
