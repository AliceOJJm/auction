class AddDefaultValueToIsFinalOfBid < ActiveRecord::Migration
  def change
    change_column :bids, :is_final, :boolean, default: false
  end
end
