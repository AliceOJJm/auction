class LotUpdater
  include Sidekiq::Worker

  def perform
    lots = Lot.includes(:bids).where('expires_at < ?', DateTime.now.in_time_zone('UTC'))
    lots.each do |lot|
      last_bid = lot.bids.last
      if last_bid.present?
        last_bid.update!(is_final: true) unless last_bid.is_final
        AuctionMailer.auction_ended_email(lot.user, lot, last_bid.user).deliver
      end
    end
  end
end
