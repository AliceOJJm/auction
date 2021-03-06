class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: [:show, :destroy]

  def index
    if params[:user_id].present?
      posts_scope = User.find(params[:user_id]).posts
    elsif params[:community_id].present?
      posts_scope = Community.find(params[:community_id]).posts
    end
    posts = posts_scope.inject([]) do |posts, post|
      root_comments = User.add_names_pics post.root_comments
      posts << {post: post, root_comments: root_comments, tags: post.tag_list.map{|tag| {text: tag}}}
    end
    respond_to do |format|
      format.html
      format.json {render json: posts}
    end
  end

  def create
    @post = Post.create(post_params)
    respond_to do |format|
      format.html 
      format.json { render json: @post }
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html 
      format.json { head :no_content }
    end
  end
 
  def toggle_like
    @post = Post.find(params[:post_id])
    current_user.toggle_like!(@post)
    respond_to do |format|
      format.html 
      format.json { render json: {increment: current_user.likes?(@post)} }
    end
  end
 
  private
  
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit!
    end
end
