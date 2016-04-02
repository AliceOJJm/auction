require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid" do
    post = Post.new
    post.should be_valid
  end
end
