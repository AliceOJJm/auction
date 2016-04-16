require 'rails_helper'

RSpec.describe "lots/new", type: :view do
  before(:each) do
    assign(:lot, Lot.new(
      :category => nil,
      :user => nil,
      :starting_price => 1,
      :current_price => 1
    ))
  end

  it "renders new lot form" do
    render

    assert_select "form[action=?][method=?]", lots_path, "post" do

      assert_select "input#lot_category_id[name=?]", "lot[category_id]"

      assert_select "input#lot_user_id[name=?]", "lot[user_id]"

      assert_select "input#lot_starting_price[name=?]", "lot[starting_price]"

      assert_select "input#lot_current_price[name=?]", "lot[current_price]"
    end
  end
end
