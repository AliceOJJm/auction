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

  validate :created_at_cannot_be_after_lot_expires_at, on: :create

  def created_at_cannot_be_after_lot_expires_at
    binding.pry
    if self.lot.present? && DateTime.now.in_time_zone('UTC') > self.lot.expires_at
      errors.add(:creation_time, "can't be after lot's expiration time")
    end
  end
end
