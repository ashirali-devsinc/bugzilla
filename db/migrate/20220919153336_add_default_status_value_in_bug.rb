class AddDefaultStatusValueInBug < ActiveRecord::Migration[7.0]
  def change
    change_column_default :bugs, :status, 0
  end
end
