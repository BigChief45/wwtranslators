class AddAttachmentAttachmentToJobs < ActiveRecord::Migration
  def self.up
    change_table :jobs do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :jobs, :attachment
  end
end
