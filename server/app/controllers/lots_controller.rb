class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :update, :destroy, :pictures, :participants]

  # GET /lots.json
  def index
    @lots = Lot.all
  end

  # GET /lots/1.json
  def show
  end

  # POST /lots.json
  def create
    @lot = Lot.new(lot_params)
    @lot.expires_at = Time.now + params[:duration].to_i.days
    @lot.current_price = @lot.starting_price

    respond_to do |format|
      if @lot.save
        format.html { redirect_to @lot, notice: 'Lot was successfully created.' }
        format.json { render :show, status: :created, location: @lot }
      else
        format.html { render :new }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lots/1.json
  def update
    respond_to do |format|
      if @lot.update(lot_params)
        format.html { redirect_to @lot, notice: 'Lot was successfully updated.' }
        format.json { render :show, status: :ok, location: @lot }
      else
        format.html { render :edit }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lots/1.json
  def destroy
    @lot.destroy
    respond_to do |format|
      format.html { redirect_to lots_url, notice: 'Lot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pictures
    pictures = Array.new
    @lot.pictures.order(created_at: :desc).each do |picture|
      root_comments = User.add_names_pics picture.root_comments
      pictures << {picture: picture, root_comments: root_comments, tags: picture.tag_list.map{|tag| {text: tag}}}
    end
    respond_to do |format|
      format.html
      format.json { render json: pictures}
    end
  end

  def participants
    user_ids = @lot.bids.pluck(:user_id)
    # TODO pluck necessary fields
    users = User.where(id: user_ids)
    respond_to do |format|
      format.json { render json: users }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lot
      @lot = Lot.find(params[:id] || params[:lot_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lot_params
      params.require(:lot).permit(:category_id, :user_id, :starting_price, :current_price, :expires_at, :title, :description)
    end
end
