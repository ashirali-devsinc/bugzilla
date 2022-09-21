class CreateProjectBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :project_bugs do |t|
      t.references :bug, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
