class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'

  def self.users_with_pending_sent_friendships(user)
    joins(:received_friendships)
      .where(friendships: { sender_id: user.id, status: 'pending' })
  end

  def self.users_with_pending_received_friendships(user)
    joins(:sent_friendships)
      .where(friendships: { receiver_id: user.id, status: 'pending' })
  end

  def self.friends(user)
    joins(:friendships)
      .where(friendships: { status: 'accepted', sender_id: user.id })
      .or(joins(:friendships)
        .where(friendships: { status: 'accepted', receiver_id: user.id }))
      .distinct
  end
end
