# == Schema Information
#
# Table name: videos
#
#  id                :integer          not null, primary key
#  url               :string(255)
#  user_id           :integer
#  title             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  attachable_id     :integer
#  attachable_type   :string(255)
#  owners            :integer          default("1")
#  likers_count      :integer          default("0")
#

require 'rails_helper'

RSpec.describe Video, type: :model do
  it "is valid" do
    video = Video.new
    video.should be_valid
  end
end
