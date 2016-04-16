class AddPostableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postable_id, :integer
    add_column :posts, :postable_type, :string
    remove_reference :posts, :user, index: true, foreign_key: true
  end
end
