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

class Subscription < ActiveRecord::Base
  belongs_to :leader, class_name: 'User'
  belongs_to :subscriber, class_name: 'User'
end
