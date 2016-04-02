require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid" do
    message = Message.new
    message.should be_valid
  end
end
