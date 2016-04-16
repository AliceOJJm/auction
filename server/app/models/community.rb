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
#

require 'elasticsearch/model'

class Community < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :posts, as: :postable
end
