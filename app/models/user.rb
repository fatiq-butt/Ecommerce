class User < ApplicationRecord
  include PgSearch::Model
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :confirmable

  after_initialize :set_default_role, if: :new_record?

  pg_search_scope :global_search, against: [:first_name, :last_name, :email, :id], using: {tsearch: {prefix: true}}

  USER = :user
  ADMIN = :admin
  ROLES = [USER, ADMIN]
  enum role: ROLES

  validate :password_validation
  validates :first_name, :last_name, presence: true

  private

  def set_default_role
    self.role ||= :user
  end

  def password_validation
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }
    rules.each do |message, regex|
      errors.add :password, message unless password.match(regex)
    end
  end
end
