require 'rails_helper'

RSpec.describe "bids/new", type: :view do
  before(:each) do
    assign(:bid, Bid.new(
      :lot => nil,
      :user => nil,
      :price => 1,
      :is_final => false
    ))
  end

  it "renders new bid form" do
    render

    assert_select "form[action=?][method=?]", bids_path, "post" do

      assert_select "input#bid_lot_id[name=?]", "bid[lot_id]"

      assert_select "input#bid_user_id[name=?]", "bid[user_id]"

      assert_select "input#bid_price[name=?]", "bid[price]"

      assert_select "input#bid_is_final[name=?]", "bid[is_final]"
    end
  end
end
