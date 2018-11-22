class Flight < ApplicationRecord
  has_many :passengers, dependent: :destroy # 2) If a flight is removed then all persons on that flight should also be removed
  has_many :users, through: :passengers

  validates :capacity, :destination_airport_code, :number, :departure_time, presence: true
  validates :number, uniqueness: { scope: :departure_time }
end
