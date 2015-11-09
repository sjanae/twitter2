class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: users, include: params[:include]
  end
  
  def new
    @user = User.new
    render json: users, include: params[:include]
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
    	render json: @user, status: :created
      	flash[:success] = "Welcome new user"
      	redirect_to @user
      else
        render json: @user.errors, status: :unprocessable_entity
    end
  end
  
	def follow
    	user = User.find(params[:user_id])
    	current_user.follow(user)
  	end

  def unfollow
    user = User.find(params[:user_id])
    current_user.stop_following(user)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
    							:password_confirmation)
  end
end
