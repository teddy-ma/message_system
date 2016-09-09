class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string  :target_email
      t.integer :conversation_id
      t.datetime :last_touch_at

      t.timestamps
    end
    add_index :contacts, [:user_id, :conversation_id], unique: true
    add_index :contacts, [:user_id, :target_email], unique: true
  end
end
