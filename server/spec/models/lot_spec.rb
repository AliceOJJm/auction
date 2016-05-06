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

require 'rails_helper'

RSpec.describe Lot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
