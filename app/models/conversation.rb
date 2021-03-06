class Conversation < ApplicationRecord
  belongs_to :user_one, class_name: User
  belongs_to :user_other, class_name: User
  has_many :messages

  validates :user_one, :user_other, presence: true
  validates :unread_count, numericality: { greater_than_or_equal_to: 0 }

  def both_user_ids
    [user_one_id, user_other_id]
  end

  def target_user(from_user)
    user_one == from_user ? user_other : user_one
  end

  def clear_unread_count(user_id)
    if user_id != last_reply_user_id
      update_attributes(unread_count: 0)
    end
  end

  def increment_unread_count(user_id)
    if user_id == last_reply_user_id
      increment(:unread_count)
      save
    else
      update_attributes(last_reply_user_id: user_id, unread_count: 1)
    end
  end

  def decrement_unread_count(user_id, destroyed_message)
    if user_id == last_reply_user_id && unread_count > 0
      other_user_id = (both_user_ids - [user_id])[0]
      last_other_user_message = self.messages.where(sender_id: other_user_id).
                                    order(created_at: :desc).first
      if last_other_user_message.nil? || (last_other_user_message.created_at < destroyed_message.created_at)
        decrement(:unread_count)
        save
      end
    end
  end

  def self.find_by_user_ids(one_id, other_id)
    small_id, big_id = [one_id, other_id].sort
    where(user_one_id: small_id, user_other_id: big_id).first
  end

  def self.create_by_user_ids(from_id, to_id)
    small_id, big_id = [from_id, to_id].sort
    create(user_one_id: small_id, user_other_id: big_id, last_reply_user_id: from_id)
  end
end
