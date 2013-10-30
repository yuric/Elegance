class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :poll_id
      t.string :content

      t.timestamps
    end
  end
end
