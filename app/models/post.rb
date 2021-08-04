# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, inverse_of: :post

  validates :title, :category, :creator, presence: true
end
