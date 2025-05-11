class LessonsController < ApplicationController
  def index
    @lessons = current_user.courses.lessons
    unless current_user.courses.any?
      redirect_to courses_path, alert: "Nessun corso trovato. Inizia a partecipare a qualche corso!"
    end

    @lessons = @lessons.order(start_time: :asc)
  end
end
