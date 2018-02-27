class User < ApplicationRecord
  has_secure_password
  validates_presence_of :first_name, :last_name, :address, :city, :state, :zip_code
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :items, through: :orders
  enum role: %w(default admin)

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    address + " " + city + " " + state + " " + zip_code.to_s
  end
end
