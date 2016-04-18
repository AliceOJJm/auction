class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :update, :destroy]

  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1.json
  def show
  end

  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    lot = Lot.find(bid_params[:lot_id])

    respond_to do |format|
      if @bid.save
        # move into callback
        lot.update(expires_at: Time.now + 1.hour) if lot.expires_at - Time.now < 20.minutes
        lot.update(current_price: @bid.price + lot.current_price)

        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:lot_id, :user_id, :price, :is_final)
    end
end
