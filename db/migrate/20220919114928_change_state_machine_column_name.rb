class ChangeStateMachineColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :manual_state_machines, :model_name, :model
    rename_column :manual_state_machines, :changes, :changes_made
  end
end
