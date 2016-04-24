# == Schema Information
#
# Table name: communities
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  aim         :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  avatar_url  :string(255)
#  owner_id    :integer
#

require 'rails_helper'

RSpec.describe Community, type: :model do
  it "is valid" do
    community = Community.new
    community.should be_valid
  end
end
