class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :liked_posts, through: :likes, source: :post

  has_one_attached :profile_pic

  after_create :attach_default_profile_pic
  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def self.from_omniauth(auth)
    user = find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    downloaded_image = URI.open(auth.info.image)
    user.profile_pic.attach(io: downloaded_image, filename: 'profile_pic.jpg')
    user
  end

  def attach_default_profile_pic
    profile_pic.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'placeholder-profile-pic.png')),
      filename: 'default-profile-pic.png',
      content_type: 'image/png'
    )
  end

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
