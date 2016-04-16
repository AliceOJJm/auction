# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  text        :text(65535)
#  sender_id   :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  dialogue_id :integer
#  viewed      :boolean          default("0")
#

class Message < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, as: :attachable
  has_many :songs, as: :attachable
  has_many :videos, as: :attachable
end
