class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :items, through: :orders
  enum role: %w(default admin)
end
