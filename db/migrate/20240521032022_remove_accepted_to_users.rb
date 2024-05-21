class RemoveAcceptedToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :accepted, :boolean
  end
end
