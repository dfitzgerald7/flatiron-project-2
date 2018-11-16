class Players < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :votes
      t.integer :team_id
      t.integer :creator_user
      t.timestamps
    end
  end
end
