require 'base64'
require 'json'

module AuthHelper

  def getAuthToken(header,payload)
    to_sign = Base64.strict_encode64(header)+"."+Base64.strict_encode64(payload)
    signedToken = SessionHelper.signAuthToken(to_sign)
    to_sign + "." + signedToken
  end

  def getHeader(algo)
    {:typ => "jwt" , :alg => algo}.to_json
  end

  def getPayload(user_email , exp_time)
    {:email => user_email , :exp => exp_time }.to_json
  end

  def auth(data)
    header,payload,signature = data.split(".")
    payload_json = JSON.parse(Base64.strict_decode64(payload))
    if payload_json["exp"] < Date.today.to_time.to_i 
      return false
    end
    if SessionHelper.checkSignedToken?( header+"."+payload , signature)
      payload_json["email"]
    else
      return false
    end
  end

  def authorise
    auth_token = cookies[:auth_token]
    if auth_token == nil 
      render json: { :err => "not authorised"} 
      return
    end
    user_email = auth(auth_token)
    if user_email
       @current_user  ||= User.find_by(email: user_email)
    else 
      render json: { :err => "not authorised"} 
    end
  end

  def unvalidate
    @current_user = nil
    cookies.delete(:auth_token)
  end

end
