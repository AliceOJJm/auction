# == Schema Information
#
# Table name: pictures
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  url               :string(255)
#  thumb_url         :string(255)
#  medium_url        :string(255)
#  attachable_id     :integer
#  attachable_type   :string(255)
#  likers_count      :integer          default("0")
#

require 'rails_helper'

RSpec.describe Picture, type: :model do
  it "is valid" do
    picture = Picture.new
    picture.should be_valid
  end
end
