class AddCountryToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :country, :string
  end
end
