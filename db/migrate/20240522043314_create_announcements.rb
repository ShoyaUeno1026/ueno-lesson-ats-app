class CreateAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :announcements do |t|
      t.string :kind
      t.datetime :published_at
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
