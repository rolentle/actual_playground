class AddTwitterUsernameToShows < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :twitter_username, :string
  end
end
