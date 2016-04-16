class AddTitleAndDescirptionToLot < ActiveRecord::Migration
  def change
    add_column :lots, :title, :string
    add_column :lots, :description, :text
  end
end
