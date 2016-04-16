# == Schema Information
#
# Table name: songs
#
#  id                :integer          not null, primary key
#  url               :string(255)
#  user_id           :integer
#  title             :string(255)
#  performer         :string(255)
#  genre             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  metadata          :text(65535)
#  attachable_id     :integer
#  attachable_type   :string(255)
#  owners            :integer          default("1")
#  likers_count      :integer          default("0")
#

require 'rails_helper'

RSpec.describe Song, type: :model do
  it "is valid" do
    song = Song.new
    song.should be_valid
  end
end
