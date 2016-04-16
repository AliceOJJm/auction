# == Schema Information
#
# Table name: pictures
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  url               :string(255)
#  thumb_url         :string(255)
#  medium_url        :string(255)
#  attachable_id     :integer
#  attachable_type   :string(255)
#  likers_count      :integer          default("0")
#

class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: true
  has_attached_file :file, :styles => { :medium => "250x250>", :thumb => "100x100>" }

  validates_attachment :file, :content_type => { :content_type => /\Aimage\/.*\Z/ },
                                :size => { :less_than => 1.megabytes }
                                
  acts_as_taggable
  acts_as_commentable
  acts_as_likeable
  
  def self.upload picture_params
    picture = Picture.create(picture_params)
    picture.url = picture.file.url
    picture.thumb_url = picture.file.url(:thumb)
    picture.medium_url = picture.file.url(:medium)
    picture.save!
    picture
  end
end
