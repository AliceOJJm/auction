# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  leader_id     :integer
#  subscriber_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  viewed        :boolean          default("0")
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it "is valid" do
    subscription = Subscription.new
    subscription.should be_valid
  end
end
