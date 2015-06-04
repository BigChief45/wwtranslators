class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
