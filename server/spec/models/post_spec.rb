# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  content       :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likers_count  :integer          default("0")
#  postable_id   :integer
#  postable_type :string(255)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid" do
    post = Post.new
    post.should be_valid
  end
end
