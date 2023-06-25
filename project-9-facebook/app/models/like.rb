class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :cannot_like_own_post

  def cannot_like_own_post
    errors.add(:base, 'Cannot like your own post!') if user == post.user
  end
end
