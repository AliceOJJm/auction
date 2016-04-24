class CommunitiesController < ApplicationController
  before_filter :set_community, only: [:show, :join, :leave, :update, :destroy]
  
  def index
    @communities = []
    if params[:user_id]
      communities = User.find(params[:user_id]).communities.order(:created_at => :desc)#.group_by(&:aim)
    else
      communities = Community.all.order(:created_at => :desc)#.group_by(&:aim)
    end
    communities.each do |community|
      @communities << {community: community, participants: community.users.count}
    end
    respond_to do |format|
      format.html
      format.json { render json: @communities}
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: {community: @community, participants: @community.users, participates: (@community.users.include? current_user)}}
    end
  end
  
  def create
    community = Community.new(community_params)
    community.save!
    community.users << current_user
    respond_to do |format|
      format.html
      format.json {render json: {id: community.id}}
    end
  end
  
  def join
    @community.users << current_user
    respond_to do |format|
      format.html 
      format.json { head :no_content }
    end
  end
  
  def leave
    @community.users.destroy current_user
    respond_to do |format|
      format.html 
      format.json { head :no_content }
    end
  end
  
  def update
    if params[:avatar_url].present? || params[:picture].present?
      @community.avatar_url = params[:avatar_url] || Picture.upload(picture_params).url
      @community.save!
      response = {avatar: @community.avatar_url}
    else
      @community.update(community_params)
      response = {community: @community}
    end
    render json: response
  end 
  
  def destroy
    @community.destroy
    render json: {status: 200}
  end
  
  private
  
  def picture_params
    params.require(:picture).permit!
  end
  
  def community_params
    params.require(:community).permit!
  end

  def set_community
    @community = Community.find(params[:id] || params[:community_id])
  end
end
