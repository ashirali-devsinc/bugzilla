class AddReferencesInBugTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :user, index: true
    add_reference :bugs, :project, index: true
  end
end
