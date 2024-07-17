require 'openssl'
require 'base64'
require 'json'

module SessionHelper
  def self.signAuthToken(data)
    key = ENV["SECRET_KEY"]
    digest =  OpenSSL::Digest.new("sha256")
    pp "key :- #{key} , data :- #{data} "
    OpenSSL::HMAC.hexdigest(digest,key,data)
  end

  def self.checkSignedToken?(data , signature)
    signed_token = signAuthToken(data)
    if signed_token == signature 
      return true
    else
      return false
    end
  end

end
