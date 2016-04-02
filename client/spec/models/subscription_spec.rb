require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it "is valid" do
    subscription = Subscription.new
    subscription.should be_valid
  end
end
