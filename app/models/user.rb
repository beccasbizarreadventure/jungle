class User < ApplicationRecord
  
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
  
end