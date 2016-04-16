# == Schema Information
#
# Table name: dialogues
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Dialogue, type: :model do
  it "is valid" do
    dialogue = Dialogue.new
    dialogue.should be_valid
  end
end
