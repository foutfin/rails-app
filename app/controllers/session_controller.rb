class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token
  include AuthHelper

  def login
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      auth_token = getAuthToken( getHeader("HS256") , getPayload(@user.email ,  5.days.from_now.to_i ) )
      puts "Auth Token #{auth_token} "
      cookies[:auth_token] = {
        :value => auth_token,
        :expires =>  5.days.from_now,
        :httponly => true,
        :domain => "localhost"
      } 
      render json: { :msg => "ok"}
    else
      render json: {:err => "not able to authorise"}
    end
  end

  def logout
    unvalidate
    render json: { :msg => "logout success"}
  end
end
