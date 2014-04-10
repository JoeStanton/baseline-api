class AddSpecToService < ActiveRecord::Migration
  def change
    add_column :services, :spec, :text
  end
end
