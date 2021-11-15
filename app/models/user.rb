class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  before_update :check_password_changed
  after_create :create_cart_for_user
  has_one :cart
  has_many :orders
    
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
    message: "should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."},
    if: :password_validation

  private

  def set_default_role
    self.role ||= :user
  end

  def create_cart_for_user
    self.create_cart!
  end

  def check_password_changed
    if encrypted_password_changed?
      self.invited_user = false
    end
  end

  def password_validation
    new_record? || encrypted_password_changed?
  end

  def self.generate_random_password
    SecureRandom.alphanumeric + SPECIAL_CHAR.sample(2).join
  end
end
