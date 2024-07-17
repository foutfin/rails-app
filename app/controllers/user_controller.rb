class UserController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    @user = User.new(name:params[:name] , email:params[:email] ,password:params[:password] , password_confirmation: params[:confirm_password] )
    if @user.save
      render json: { :msg => "success"}
      return
    end
    render json: { :err => @user.errors.full_messages}
  end

  
end
