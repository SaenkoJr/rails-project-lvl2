# frozen_string_literal: true

PostCategory.delete_all
3.times do |i|
  PostCategory.create(name: "Category #{i}")
end
