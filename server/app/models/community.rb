# == Schema Information
#
# Table name: communities
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  aim         :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  avatar_url  :string(255)
#  owner_id    :integer
#

class Community < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :posts, as: :postable

  searchable do
    text :title, :aim, boost: 5.0
    text :description
  end
  
  def self.fulltext_search search_by
    Community.search{fulltext search_by}.results
  end
end
