class AuctionMailer < ApplicationMailer
  default from: "info@auction.by"

  def auction_ended_email(user, lot, winner)
    @user = user
    @lot = lio
    @winner = winner
    mail(to: @user.email, subject: 'Auction ended')
  end
end
