class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :show, foreign_key: true, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
