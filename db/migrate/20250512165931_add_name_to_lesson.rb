class AddNameToLesson < ActiveRecord::Migration[8.0]
  def change
    add_column :lessons, :name, :string
  end
end
