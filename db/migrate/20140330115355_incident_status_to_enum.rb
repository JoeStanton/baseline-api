class IncidentStatusToEnum < ActiveRecord::Migration
  def change
   add_column :incidents, :status_enum, :integer, default: 0

    # You need to tell ActiveRecord to refresh the object
    Incident.reset_column_information
    Incident.all.each do |i|
      i.status == Incident.statuses[i.status]
      i.save
    end

    remove_column :incidents, :status
    rename_column :incidents, :status_enum, :status
  end
end
