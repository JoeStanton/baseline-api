class ServiceStatusToEnum < ActiveRecord::Migration
  def change
   add_column :services, :status_enum, :integer, default: 0

    # You need to tell ActiveRecord to refresh the object
    Service.reset_column_information
    Service.all.each do |i|
      i.status == Service.statuses[i.status]
      i.save
    end

    remove_column :services, :status
    rename_column :services, :status_enum, :status
  end
end
