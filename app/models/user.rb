class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/
  
  validates :first_name, :last_name, presence: true
  validates :password, format: {
    with: PASSWORD_REGEX,
    message: "should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."
  }         
end
