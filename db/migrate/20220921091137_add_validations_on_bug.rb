class AddValidationsOnBug < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bugs, :title, false
    change_column_null :bugs, :description, false
    change_column_null :bugs, :nature, false
  end
end
