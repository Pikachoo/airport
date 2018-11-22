class User < ApplicationRecord
  has_many :passengers
  has_many :flights, through: :passengers

  validates :name, :email, :phone, presence: true
  validates :email, uniqueness: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
