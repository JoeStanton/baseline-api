class EventStatusToEnum < ActiveRecord::Migration
  def change
   add_column :events, :status_enum, :integer, default: 0

    # You need to tell ActiveRecord to refresh the object
    Event.reset_column_information
    Event.all.each do |i|
      i.status == Event.statuses[i.status]
      i.save
    end

    remove_column :events, :status
    rename_column :events, :status_enum, :status
  end
end
