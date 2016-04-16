require 'rails_helper'

RSpec.describe "lots/index", type: :view do
  before(:each) do
    assign(:lots, [
      Lot.create!(
        :category => nil,
        :user => nil,
        :starting_price => 1,
        :current_price => 2
      ),
      Lot.create!(
        :category => nil,
        :user => nil,
        :starting_price => 1,
        :current_price => 2
      )
    ])
  end

  it "renders a list of lots" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
