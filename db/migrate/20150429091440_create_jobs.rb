class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :source_language
      t.string :target_language
      t.string :deadline

      t.timestamps
    end
  end
end
