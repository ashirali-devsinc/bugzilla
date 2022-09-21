class CreateManualStateMachines < ActiveRecord::Migration[7.0]
  def change
    create_table :manual_state_machines do |t|
      t.references :user, null: false, foreign_key: true
      t.string :model_name
      t.json :changes

      t.timestamps
    end
  end
end
