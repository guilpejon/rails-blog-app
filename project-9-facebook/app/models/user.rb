class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'

  has_one_attached :profile_pic

  def self.users_with_pending_sent_friendships(user)
    joins(:received_friendships)
      .where(friendships: { sender_id: user.id, status: :pending })
  end

  def self.users_with_pending_received_friendships(user)
    joins(:sent_friendships)
      .where(friendships: { receiver_id: user.id, status: :pending })
  end

  def self.friends(user)
    joins("INNER JOIN friendships ON (users.id = friendships.receiver_id AND friendships.sender_id = #{user.id} AND friendships.status = 1) OR (users.id = friendships.sender_id AND friendships.receiver_id = #{user.id} AND friendships.status = 1)")
      .distinct
  end

  def self.friendships(user)
    Friendship.where('sender_id = :user_id OR receiver_id = :user_id', user_id: user.id)
  end

  def self.friendship_requests(user)
    Friendship.pending.where(receiver_id: user.id)
  end
end
