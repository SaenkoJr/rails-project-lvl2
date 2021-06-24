class AddCreatorToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :creator_id, :bigint, null: false
  end
end
