require 'rails_helper'

RSpec.describe "bids/edit", type: :view do
  before(:each) do
    @bid = assign(:bid, Bid.create!(
      :lot => nil,
      :user => nil,
      :price => 1,
      :is_final => false
    ))
  end

  it "renders the edit bid form" do
    render

    assert_select "form[action=?][method=?]", bid_path(@bid), "post" do

      assert_select "input#bid_lot_id[name=?]", "bid[lot_id]"

      assert_select "input#bid_user_id[name=?]", "bid[user_id]"

      assert_select "input#bid_price[name=?]", "bid[price]"

      assert_select "input#bid_is_final[name=?]", "bid[is_final]"
    end
  end
end
