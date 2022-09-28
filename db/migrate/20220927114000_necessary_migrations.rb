class NecessaryMigrations < ActiveRecord::Migration[7.0]
  def change
    remove_column :bugs, :status
    add_column :workloads, :status, :integer
    change_column_null :workloads, :status, false, 0
    change_column_default :workloads, :status, 0
  end
end
