class Friendship < ApplicationRecord
  enum status: %i[pending accepted]

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender, presence: true
  validates :receiver, presence: true

  validate :cannot_send_friend_request_to_self

  def cannot_send_friend_request_to_self
    errors.add(:base, 'Cannot send friend request to yourself') if sender == receiver
  end
end
