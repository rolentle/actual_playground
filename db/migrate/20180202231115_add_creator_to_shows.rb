class AddCreatorToShows < ActiveRecord::Migration[5.1]
  def change
    add_reference :shows, :creator, polymorphic: true
  end
end
