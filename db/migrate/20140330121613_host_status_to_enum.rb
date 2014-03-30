class HostStatusToEnum < ActiveRecord::Migration
  def change
   add_column :hosts, :status_enum, :integer, default: 0

    # You need to tell ActiveRecord to refresh the object
    Host.reset_column_information
    Host.all.each do |i|
      i.status == Host.statuses[i.status]
      i.save
    end

    remove_column :hosts, :status
    rename_column :hosts, :status_enum, :status
  end
end
