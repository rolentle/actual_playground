class AddStatusToShows < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :status, :string, default: 'pending'
  end
end
