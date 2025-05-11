class RenameCourseServerIdToCourseCode < ActiveRecord::Migration[8.0]
  def change
    rename_column :courses, :server_id, :code
  end
end
