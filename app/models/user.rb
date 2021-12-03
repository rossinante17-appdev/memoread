class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }
  has_secure_password
end
