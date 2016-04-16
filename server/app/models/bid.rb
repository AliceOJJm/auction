# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  lot_id     :integer
#  user_id    :integer
#  price      :integer
#  is_final   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bid < ActiveRecord::Base
  belongs_to :lot
  belongs_to :user
end
