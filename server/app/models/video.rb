# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  url             :string(255)
#  user_id         :integer
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :integer
#  attachable_type :string(255)
#  owners          :integer          default("1")
#  likers_count    :integer          default("0")
#

class Video < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :attachable, polymorphic: true
  
  has_attached_file :file

  validates_attachment :file, :content_type => { :content_type => /\Avideo\/.*\Z/},
                              :size => { :less_than => 2.gigabytes }
  acts_as_taggable
  acts_as_likeable
  acts_as_commentable
  
  searchable do
    text :title, boost: 5.0
  end
  
  def self.fulltext_search search_by
    Video.search{fulltext search_by}.results
  end
end
