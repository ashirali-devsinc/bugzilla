class DropCreaters < ActiveRecord::Migration[7.0]
  def change
    drop_table :creaters
  end
end
