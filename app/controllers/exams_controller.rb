class ExamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.courses
    exams = Exam.where(course_id: @courses.pluck(:id))
      .upcoming
      .order(date: :asc, start_time: :asc)

    @exams_by_month = exams.group_by { |exam| exam.date.beginning_of_month }

    unless exams.any?
      if current_user.courses.any?
        redirect_to courses_path, alert: "Nessun esame trovato per i tuoi corsi. Vai a bere!"
      else
        redirect_to courses_path, alert: "Nessun corso aggiunto. Aggiungi almeno un corso per vedere gli esami."
      end
    end
  end
end
