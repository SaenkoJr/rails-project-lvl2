# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :creator, class_name: 'User'

  validates :title, :post_category, :creator, presence: true
end
