class ChangeStatusToIntOnShows < ActiveRecord::Migration[5.1]
  def change
    remove_column :shows, :status
    add_column :shows, :status, :integer, default: 0
  end
end
