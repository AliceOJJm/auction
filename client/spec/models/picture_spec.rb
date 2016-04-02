require 'rails_helper'

RSpec.describe Picture, type: :model do
  it "is valid" do
    picture = Picture.new
    picture.should be_valid
  end
end
