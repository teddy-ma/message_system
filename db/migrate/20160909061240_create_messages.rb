class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :sender_id
      t.integer :conversation_id

      t.timestamps
    end
    add_index :messages, :conversation_id
    add_index :messages, :sender_id
  end
end
