class User < ActiveRecord::Base
#  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/
#  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 8, maximum: 20 }, format: { with: VALID_USERNAME_REGEX, message: 'must be a combination of 8-20 characters and/or numbers with no special characters.'}
  has_secure_password
#  validates :password, length: { minimum: 8 }
end
