# frozen_string_literal: true

class Post::Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :not_post_owner

  def not_post_owner
    errors.add(:base, 'You cannot like your post') if user == post.creator
  end
end
