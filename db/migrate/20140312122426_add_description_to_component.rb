class AddDescriptionToComponent < ActiveRecord::Migration
  def change
    add_column :components, :description, :string
  end
end
