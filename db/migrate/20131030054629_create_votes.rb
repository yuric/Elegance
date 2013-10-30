class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :ip
      t.string :browser
      t.float :latitude
      t.float :longitude
      t.integer :answer_id

      t.timestamps
    end
  end
end
