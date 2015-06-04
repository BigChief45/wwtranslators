class ChangeUserIdToPosterId < ActiveRecord::Migration
  def change
    rename_column :jobs, :user_id, :poster_id
  end
end
