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

require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid" do
    message = Message.new
    message.should be_valid
  end
end
