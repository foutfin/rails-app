class PostController < ApplicationController
  include AuthHelper
  before_action :authorise
  
  def allPost
    render json: { :posts => [] , :user => @current_user.name}
  end
end
