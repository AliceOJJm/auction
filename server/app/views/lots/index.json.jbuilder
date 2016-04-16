json.array!(@lots) do |lot|
  json.extract! lot, :id, :category_id, :user_id, :starting_price, :current_price, :expires_at
  json.url lot_url(lot, format: :json)
end
