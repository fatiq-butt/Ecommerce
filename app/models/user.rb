class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :confirmable

  validate :password_validation
  validates :first_name, :last_name, presence: true

  private

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
