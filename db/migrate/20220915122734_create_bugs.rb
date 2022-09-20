class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.date :deadline
      t.integer :type
      t.integer :status

      t.timestamps
    end
  end
end
