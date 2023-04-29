class UsersController < ApplicationController

  require 'byebug'

  def create
    data = JSON.parse(request.body.read)
    @user = User.new(user_params(data))
    if @user.save
      render json: { message: "Usuário criado com sucesso" }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params(data)
    ActionController::Parameters.new(data).permit(:email, :password)
  end
end
