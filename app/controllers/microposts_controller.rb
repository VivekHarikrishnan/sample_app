class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy  

  def index
  end

  def create
  	@micropost = current_user.microposts.build(params[:micropost])

  	if @micropost.save
  		redirect_to root_path, notice: "Micropost created"
  	else
      @feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    current_user.microposts.find(params[:id]).destroy
  end

  private

    def correct_user
      # Method 1 ---------------
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path, notice: 'Can not delete this post' if @micropost.nil?

      # Method 2 commented ---------------
      # @micropost = Micropost.find_by_id(params[:id])
      # redirect_to root_path, notice: 'Can not delete this post' unless current_user?(@micropost.user)
      # Both the ways it can be implemented. 
      # But it is a good practice always to run lookups through the association
    end
end
