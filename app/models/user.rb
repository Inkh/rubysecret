class User < ApplicationRecord
  has_many :secrets
  has_many :likes
  has_many :secrets, through: :likes

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :name, presence: true, length: { minimum: 2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX}

  before_save do
    self.name.downcase!
    self.email.downcase!
  end
end
