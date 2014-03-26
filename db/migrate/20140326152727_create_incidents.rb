class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :status
      t.references :service, index: true
      t.references :components, index: true
      t.references :hosts, index: true
      t.date :resolved_at
      t.string :resolved_by
      t.string :root_cause

      t.timestamps
    end
  end
end
