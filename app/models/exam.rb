class Exam < ApplicationRecord
  belongs_to :course

  validates :server_id, uniqueness: true
  validates :date, :start_time, :end_time, presence: true

  scope :upcoming, -> { where("date >= ?", Date.today).order(date: :asc, start_time: :asc) }
end
