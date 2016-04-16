require 'rails_helper'

RSpec.describe "lots/show", type: :view do
  before(:each) do
    @lot = assign(:lot, Lot.create!(
      :category => nil,
      :user => nil,
      :starting_price => 1,
      :current_price => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
