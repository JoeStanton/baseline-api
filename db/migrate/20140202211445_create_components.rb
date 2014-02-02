class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.string :type
      t.string :version
      t.string :status
      t.integer :service_id

      t.timestamps
    end
  end
end
