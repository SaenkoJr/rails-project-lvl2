# frozen_string_literal: true

class RenamePostCategoryIdToCategoryId < ActiveRecord::Migration[6.1]
  def change
    rename_column(:posts, :post_category_id, :category_id)
  end
end
