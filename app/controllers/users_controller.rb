class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :following, :followers, :search]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def search
    @search_query = params[:search]
    @users = @search_query.blank? ? [] : User.find_by_sql("SELECT * FROM users WHERE name RLIKE '#{@search_query}'")

    respond_to do |format|
      format.js
    end
  end

  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to Microposts !!"
  		redirect_to @user
  	else
      # flash[:error] = "There are error(s) in submitting your request"
  		render 'new'
  	end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "Invalid access" unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
