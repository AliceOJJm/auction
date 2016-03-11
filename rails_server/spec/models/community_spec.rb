require 'rails_helper'

RSpec.describe Community, type: :model do
  it "is valid" do
    community = Community.new
    community.should be_valid
  end
end
