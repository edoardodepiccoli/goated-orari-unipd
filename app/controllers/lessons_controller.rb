class LessonsController < ApplicationController
  def index
    @courses = current_user.courses
    @lessons = Lesson.where(course_id: @courses.pluck(:id))
      .upcoming
      .order(date: :asc, start_time: :asc)

    unless @lessons.any?
      redirect_to courses_path, alert: "Nessuna lezione trovata per i tuoi corsi. Meglio così AHAHAH!"
    end
  end
end
