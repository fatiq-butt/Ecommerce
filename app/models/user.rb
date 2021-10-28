class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/,
   message: "The password should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."}
           
end
