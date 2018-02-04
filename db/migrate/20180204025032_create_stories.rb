class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.references :show, foreign_key: true
      t.references :storyable, polymorphic: true

      t.timestamps
    end
  end
end
