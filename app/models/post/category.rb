# frozen_string_literal: true

class Post::Category < ApplicationRecord
  has_many :posts, inverse_of: :category, dependent: :destroy
end
