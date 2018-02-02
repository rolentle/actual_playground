class CreatePerformerGroupsPerformers < ActiveRecord::Migration[5.1]
  def change
    create_table :performer_groups_performers do |t|
      t.references :performer_group, foreign_key: true
      t.references :performer, foreign_key: true

      t.timestamps
    end
  end
end
