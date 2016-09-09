class Conversation < ApplicationRecord
  belongs_to :user_one, class_name: User
  belongs_to :user_other, class_name: User
  has_many :messages

  validates :user_one, :user_other, presence: true
  validates :unread_count, numericality: { greater_than_or_equal_to: 0 }

end
