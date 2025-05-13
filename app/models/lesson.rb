class Lesson < ApplicationRecord
  belongs_to :course

  validates :server_id, presence: true, uniqueness: true
  validates :room, :start_time, :end_time, :date, presence: true

  scope :upcoming, -> { where("date >= ?", Date.today).order(date: :asc, start_time: :asc, end_time: :asc) }
end
