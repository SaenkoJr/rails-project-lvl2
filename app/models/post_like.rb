# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post, inverse_of: :likes

  validate :not_post_owner

  private

  def not_post_owner
    errors.add(:user, :post_owner) if user == post.creator
  end
end
