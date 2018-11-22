require 'grape_entity'
module Airport
  module Entities
    class Flight < Grape::Entity
      expose :destination_airport_code
      expose :departure_time
      expose :number
      expose :capacity
      expose :users, :using => Airport::Entities::User
      expose :created_at
      expose :updated_at
    end
  end
end
