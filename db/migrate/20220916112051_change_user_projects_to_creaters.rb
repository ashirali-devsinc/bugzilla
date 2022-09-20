class ChangeUserProjectsToCreaters < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_projects, :creaters
  end
end
