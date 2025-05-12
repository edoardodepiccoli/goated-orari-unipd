class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.timestamps

      t.string :server_id # also called "event_id" on the response
      t.string :name
      t.string :teacher
      t.string :site
      t.string :room
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.string :professor_email

      t.references :course, null: false, foreign_key: true
    end
  end
end
