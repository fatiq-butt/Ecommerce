class User < ApplicationRecord
 
  USER = :user
  ADMIN = :admin
  ROLES = [USER, ADMIN]
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/, message: "The password should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."}
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  def set_default_role
    self.role ||= :user
  end
  
end
