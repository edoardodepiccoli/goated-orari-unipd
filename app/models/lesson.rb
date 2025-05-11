class Lesson < ApplicationRecord
  belongs_to :course

  validates :server_id, presence: true, uniqueness: true
  validates :teacher, :room, :start_time, :end_time, presence: true
end
