class LessonsController < ApplicationController
  def index
    @courses_codes = current_user.courses.pluck(:code)
    @lessons = Lesson.all

    unless @lessons.any?
      redirect_to courses_path, alert: "Nessuna lezione trovata per i tuoi corsi. Meglio così AHAHAH!"
    end

    @lessons = @lessons.order(start_time: :asc)
  end
end
