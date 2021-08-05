# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :posts, inverse_of: :category, dependent: :destroy
end
