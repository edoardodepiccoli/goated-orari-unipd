class CreateExamCourseCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :exam_course_codes do |t|
      t.timestamps

      t.references :course, null: false, foreign_key: true
      t.string :code, null: false
    end
  end
end
