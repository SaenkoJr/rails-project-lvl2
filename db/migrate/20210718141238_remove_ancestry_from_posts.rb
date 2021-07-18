class RemoveAncestryFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_index :posts, :ancestry
    remove_column :posts, :ancestry, :string
  end
end
