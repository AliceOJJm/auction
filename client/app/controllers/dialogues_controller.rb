class DialoguesController < ApplicationController
  def index
    dialogues = Auction::API.get("users/#{current_user.id}/dialogues")
    respond_to do |format|
      format.html
      format.json { render json: dialogues}
    end
  end
  
  def show
    dialogue_messages = Dialogue.find(params[:id]).messages.where(:user_id => params[:user_id])
    dialogue_messages.each do |message|
      message.viewed = true
      message.save!
    end
    messages = User.add_names_pics_messages dialogue_messages
    respond_to do |format|
      format.html
      format.json { render json: messages}
    end
  end
  
  def destroy
    Message.where(:dialogue_id => params[:id], :user_id => params[:user_id]).destroy_all
    respond_to do |format|
      format.html
      format.json {head :no_content}
    end
  end
end
