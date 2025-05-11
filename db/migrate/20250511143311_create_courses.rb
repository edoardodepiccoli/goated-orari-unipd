class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :server_id
      t.string :name

      t.timestamps
    end
  end
end
