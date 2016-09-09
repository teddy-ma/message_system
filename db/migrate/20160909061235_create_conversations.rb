class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :user_one_id
      t.integer :user_other_id
      t.integer :unread_count, default: 0
      t.integer :last_reply_user_id

      t.timestamps
    end
    add_index :conversations, [:user_one_id, :user_other_id], unique: true
  end
end
