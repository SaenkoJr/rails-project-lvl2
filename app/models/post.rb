# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :post_category, inverse_of: :posts
  has_many :comments,
           inverse_of: :post,
           dependent: :destroy,
           class_name: 'PostComment'
  has_many :likes,
           dependent: :destroy,
           inverse_of: :post,
           class_name: 'PostLike'

  validates :title, :post_category, :creator, presence: true
end
