class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  Email_regex =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name , presence: true , length: {maximum: 50}
  validates :email , presence: true , length: {maximum: 255} , format: {with: Email_regex } , uniqueness: true
  validates :password , length:{ minimum: 6}
  has_secure_password
end
