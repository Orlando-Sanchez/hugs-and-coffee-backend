class UsersController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user,  only: [:current]
    
  # Call this method to check if the user is logged-in.
  # If the user is logged-in we will return the user's information.
  def current
    current_user.update!(last_login: Time.now)
    render json: current_user
  end

  # Method to create a new user using the safe params we setup.
  def create
    user = User.new(user_params)
    if user.valid? && user.save
      render json: {msg: 'User was created.'}, status: 200
    else
      render json: {msg: user.errors.messages }, status: 400
    end
  end

  private
  
  # Setting up strict parameters for when we add account creation.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end 
end