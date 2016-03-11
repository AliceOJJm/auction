require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without an email" do
    user = User.new(email: nil)
    user.should_not be_valid
  end
end
