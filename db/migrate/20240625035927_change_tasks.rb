class ChangeTasks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :task, :content
    change_column :tasks, :content, :string
    change_column :tasks, :state, :string
  end
end
