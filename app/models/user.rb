class User < ActiveRecord::Base
  validates_presence_of :name, :email
  
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: {case_sensitive: false}

  validates :password, length: { minimum: 6 }, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  
  has_secure_password
end
