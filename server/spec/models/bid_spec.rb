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

require 'rails_helper'

RSpec.describe Bid, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
