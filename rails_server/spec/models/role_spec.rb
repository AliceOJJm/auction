require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid" do
    role = Role.new
    role.should be_valid
  end
end
