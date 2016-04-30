class AddTypeToLots < ActiveRecord::Migration
  def change
    add_column :lots, :lot_type, :integer, limit: 1, default: 1, null: false
  end
end
