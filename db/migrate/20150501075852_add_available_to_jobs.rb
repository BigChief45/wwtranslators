class AddAvailableToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :available, :boolean, :default => true
  end
end
