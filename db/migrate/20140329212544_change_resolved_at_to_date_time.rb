class ChangeResolvedAtToDateTime < ActiveRecord::Migration
  def change
    change_column :incidents, :resolved_at, :datetime
  end
end
