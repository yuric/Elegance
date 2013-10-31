class AddPollIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :poll_id, :integer, :null => false, :default => 0
  end
end
