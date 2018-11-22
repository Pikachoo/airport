require 'grape_entity'
module Airport
  module Entities
    class Passenger < Grape::Entity
      expose :user, :using => Airport::Entities::User
      expose :flight, :using => Airport::Entities::Flight
      expose :created_at
      expose :updated_at
    end
  end
end
