require 'rails_helper'

RSpec.describe Song, type: :model do
  it "is valid" do
    song = Song.new
    song.should be_valid
  end
end
