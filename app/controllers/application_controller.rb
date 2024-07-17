class ApplicationController < ActionController::Base
  def ping 
    # puts "Environment key #{ENV["SECRECT_KEY"]} "
    render plain: "pong"
  end
end
