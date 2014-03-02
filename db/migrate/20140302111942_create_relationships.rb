class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :source_type
      t.integer :source_id
      t.string :target_type
      t.integer :target_id
      t.string :type

      t.timestamps
    end
  end
end
