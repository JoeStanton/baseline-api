class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip
      t.string :environment
      t.string :status
      t.integer :service_id

      t.timestamps
    end
  end
end
