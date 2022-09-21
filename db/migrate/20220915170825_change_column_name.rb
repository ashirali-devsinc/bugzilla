class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :bugs, :type, :nature
  end
end
