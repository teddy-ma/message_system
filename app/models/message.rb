class Message < ApplicationRecord
  belongs_to :sender, class_name: User
  belongs_to :conversation

  validates :sender, :conversation, presence: true
  validates :body, length: { minimum: 1, maximum: 200 }

end
