class AddUniqueIndexToCourses < ActiveRecord::Migration[8.0]
  def change
    add_index :courses, :server_id, unique: true
  end
end
