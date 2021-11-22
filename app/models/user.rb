class User < ApplicationRecord
  include PgSearch::Model
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  after_initialize :set_default_role, if: :new_record?

  pg_search_scope :global_search, against: [:first_name, :last_name, :email, :id], using: {tsearch: {prefix: true}}

  USER = :user
  ADMIN = :admin
  ROLES = [USER, ADMIN]
  enum role: ROLES
  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/
  validates :first_name, :last_name, presence: true
  validates :password, format: {
    with: PASSWORD_REGEX,
    message: "should be atleast 8 characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like !*?$%^&)."
  }

  private

  def set_default_role
    self.role ||= :user
  end
end
