class AddTranslatorIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :translator_id, :integer
  end
end
