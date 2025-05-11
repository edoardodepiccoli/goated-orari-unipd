class AddColumnsToLesson < ActiveRecord::Migration[8.0]
  def change
    add_column :lessons, :server_id, :string

    add_column :lessons, :teacher, :string
    add_column :lessons, :room, :string

    add_column :lessons, :start_time, :datetime
    add_column :lessons, :end_time, :datetime

    add_reference :lessons, :course, foreign_key: true
  end
end
