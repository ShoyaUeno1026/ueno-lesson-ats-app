class RenameVisilibityColumnToJobs < ActiveRecord::Migration[7.1]
  def change
    rename_column :jobs, :visilibity, :visibility
  end
end
