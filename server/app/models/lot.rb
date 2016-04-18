# == Schema Information
#
# Table name: lots
#
#  id             :integer          not null, primary key
#  category_id    :integer
#  user_id        :integer
#  starting_price :integer
#  current_price  :integer
#  expires_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string(255)
#  description    :text(65535)
#

class Lot < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :bids
  has_many :pictures, as: :attachable
end
