json.array!(@bids) do |bid|
  json.extract! bid, :id, :lot_id, :user_id, :price, :is_final
end
