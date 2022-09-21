class RemoveProjectFromBugs < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bugs, :project, index: true
  end
end
