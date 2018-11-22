class Passenger < ApplicationRecord
  belongs_to :flight
  belongs_to :user

  validates :flight_id, :user_id, presence: true
  validates :flight_id, uniqueness: { scope: :user_id }

  validate :flight_capacity, on: :create # 1) A flight has a fixed number of seats and if it is full then you should not be able to add a person

  private

  def flight_capacity
    return if flight.capacity > flight.passengers.count

    errors.add(:flight, :is_full)
  end
end
