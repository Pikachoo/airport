require 'grape_entity'
module Airport
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :phone
      expose :created_at
      expose :updated_at
    end
  end
end
