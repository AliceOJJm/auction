class AddAvatarUrlToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :avatar_url, :string
    add_column :communities, :owner_id, :integer
  end
end
