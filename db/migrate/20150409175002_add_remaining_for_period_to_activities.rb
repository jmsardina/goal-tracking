class AddRemainingForPeriodToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :remaining_for_period, :integer
  end
end
