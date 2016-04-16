require 'rails_helper'

RSpec.describe "bids/index", type: :view do
  before(:each) do
    assign(:bids, [
      Bid.create!(
        :lot => nil,
        :user => nil,
        :price => 1,
        :is_final => false
      ),
      Bid.create!(
        :lot => nil,
        :user => nil,
        :price => 1,
        :is_final => false
      )
    ])
  end

  it "renders a list of bids" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
