class AddValidationsOnProject < ActiveRecord::Migration[7.0]
  def change
    change_column_null :projects, :title, false
    change_column_null :projects, :description, false
  end
end
