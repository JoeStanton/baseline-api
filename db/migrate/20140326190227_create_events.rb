class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :service, index: true
      t.references :component, index: true
      t.references :host, index: true
      t.references :incident, index: true
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
