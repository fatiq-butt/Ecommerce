class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  
  USER = :user
  ADMIN = :admin
  ROLES = [USER, ADMIN]
  enum role: ROLES
  
  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/
  SPECIAL_CHAR = ["+", "-", "&&", "||", "!", "(", ")", "{", "}", "[", "]", "^","~", "*", "?", ":"]

  after_initialize :set_default_role, if: :new_record?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, format: {
    with: PASSWORD_REGEX, 
    message: "should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."}
  
  def set_default_role
    self.role ||= :user
  end
end
