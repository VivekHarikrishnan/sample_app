class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      flash[:success] = "Welcome to Sample Application !!"
  		redirect_to @user
  	else
      # flash[:error] = "There are error(s) in submitting your request"
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end
end
