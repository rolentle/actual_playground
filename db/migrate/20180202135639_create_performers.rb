class CreatePerformers < ActiveRecord::Migration[5.1]
  def change
    create_table :performers do |t|
      t.string :name

      t.timestamps
    end
  end
end
