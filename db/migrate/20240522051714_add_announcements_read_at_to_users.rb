class AddAnnouncementsReadAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :announcements_read_at, :datetime
  end
end
