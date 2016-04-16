class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :lot, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :price
      t.boolean :is_final

      t.timestamps null: false
    end
  end
end
