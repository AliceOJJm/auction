require 'rails_helper'

RSpec.describe Video, type: :model do
  it "is valid" do
    video = Video.new
    video.should be_valid
  end
end
