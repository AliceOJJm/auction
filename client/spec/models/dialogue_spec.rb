require 'rails_helper'

RSpec.describe Dialogue, type: :model do
  it "is valid" do
    dialogue = Dialogue.new
    dialogue.should be_valid
  end
end
