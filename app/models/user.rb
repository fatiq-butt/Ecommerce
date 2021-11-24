class User < ApplicationRecord
  include PgSearch::Model

  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :confirmable

  pg_search_scope :global_search, against: [:first_name, :last_name, :email, :id], using: { tsearch: { prefix: true } }

  SPECIAL_CHAR = ["+", "-", "&&", "||", "!", "(", ")", "{", "}", "[", "]", "^","~", "*", "?", ":"].freeze
  ROLES = [:user, :admin].freeze
  enum role: ROLES, _default: :user

  validate :password_validation, if: :password_changed
  validates :first_name, :last_name, presence: true

  private

  def self.csv_attributes
    [:id, :email, :first_name, :last_name, :role]
  end

  def check_password_changed
    if encrypted_password_changed?
      self.invited_user = false
    end
  end

  def password_changed
    new_record? || encrypted_password_changed?
  end

  def self.generate_random_password
    SecureRandom.alphanumeric + SPECIAL_CHAR.sample(2).join
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
