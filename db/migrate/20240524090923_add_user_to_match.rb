class AddUserToMatch < ActiveRecord::Migration[7.1]
  def change
    add_reference :matches, :user, foreign_key: true
  end
end
