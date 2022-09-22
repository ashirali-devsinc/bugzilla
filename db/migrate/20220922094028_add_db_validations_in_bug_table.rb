class AddDbValidationsInBugTable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bugs, :description, true
    change_column_null :bugs, :status, false
    add_index :bugs, :title, :unique => true
  end
end
