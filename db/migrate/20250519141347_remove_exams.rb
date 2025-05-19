class RemoveExams < ActiveRecord::Migration[8.0]
  def change
    # Remove foreign key constraints first
    remove_foreign_key :exams, :courses
    remove_foreign_key :exam_course_codes, :courses

    # Remove indexes
    remove_index :exams, :course_id
    remove_index :exam_course_codes, :course_id

    # Drop the tables
    drop_table :exams
    drop_table :exam_course_codes
  end
end
