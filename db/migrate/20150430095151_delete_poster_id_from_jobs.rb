class DeletePosterIdFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :poster_id
    remove_column :jobs, :worker_id
  end
end
