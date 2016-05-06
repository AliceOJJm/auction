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
#  lot_type       :integer          default("1"), not null
#

class Lot < ActiveRecord::Base
  extend Enumerize

  enumerize :lot_type, :in => {
    raising: 1, reducing: 2
  }, scope: true, default: :raising, predicates: true

  belongs_to :category
  belongs_to :user

  has_many :bids
  has_many :pictures, as: :attachable

  searchable do
    text :title, :description
  end
  
  def self.fulltext_search search_by
    Lot.search{fulltext search_by}.results
  end

  def update_price(bid_price)
    updated_price = if raising? then bid_price else current_price - bid_price end
    update(current_price: updated_price)
  end
end
