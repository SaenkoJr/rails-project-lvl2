# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :posts, inverse_of: :post, dependent: :destroy
end
