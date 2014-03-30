class ComponentStatusToEnum < ActiveRecord::Migration
  def change
   add_column :components, :status_enum, :integer, default: 0

    # You need to tell ActiveRecord to refresh the object
    Component.reset_column_information
    Component.all.each do |i|
      i.status == Component.statuses[i.status]
      i.save
    end

    remove_column :components, :status
    rename_column :components, :status_enum, :status
  end
end
