class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :status, default: 'pending'

      t.timestamps
    end

    add_index :friendships, %i[sender_id receiver_id], unique: true
  end
end
