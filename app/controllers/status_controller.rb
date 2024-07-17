class StatusController < ApplicationController
  include AuthHelper
  before_action :authorise

  def app
    render json: { :msg => "ok"}
  end
end
