class AddJobIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :job_id, :integer
  end
end
