class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, :conversation, :last_touch_at, presence: true

end
