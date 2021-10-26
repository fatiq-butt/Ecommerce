class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/, message: "The password should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

end
