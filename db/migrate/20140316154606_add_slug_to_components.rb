class AddSlugToComponents < ActiveRecord::Migration
  def change
    add_column :components, :slug, :string
  end
end
