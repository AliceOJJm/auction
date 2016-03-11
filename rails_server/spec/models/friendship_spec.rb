require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it "is valid" do
    friendship = Friendship.new
    friendship.should be_valid
  end
end
