class CoursesController < ApplicationController
  def sync
    Course.sync!
    render json: { message: "Courses synced successfully" }
  end
end
