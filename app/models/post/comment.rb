# frozen_string_literal: true

class Post::Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_ancestry

  validates :content, presence: true
end
