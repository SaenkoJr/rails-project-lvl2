# frozen_string_literal: true

Post::Category.delete_all
3.times do |i|
  Post::Category.create(name: "Category #{i}")
end
