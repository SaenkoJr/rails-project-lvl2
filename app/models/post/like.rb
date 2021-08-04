# frozen_string_literal: true

class Post::Like < ApplicationRecord
  belongs_to :user, inverse_of: :post_likes
  belongs_to :post, inverse_of: :likes

  validate :not_post_owner

  def not_post_owner
    errors.add(:user, :post_owner) if user == post.creator
  end
end
