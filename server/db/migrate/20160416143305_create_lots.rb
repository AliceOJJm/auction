class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :starting_price
      t.integer :current_price
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
