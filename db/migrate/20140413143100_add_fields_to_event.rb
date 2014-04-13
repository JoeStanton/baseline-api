class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :url, :string
    add_column :events, :author, :string
    add_column :events, :repo, :string
    add_column :events, :branch, :string
    add_column :events, :commit, :string
  end
end
