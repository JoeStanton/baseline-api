class AddMessageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :message, :string
  end
end
