module Airport
  class Passengers < Grape::API
    resource :passengers do
      desc '6. A route to return all people along with their flight' do
        success model: Airport::Entities::Passenger
      end
      get do
        present Passenger.joins(:flight).all, with: Airport::Entities::Passenger
      end

      desc '4) A route to add a person to a flight. A person has a name, phone number, and email address'
      params do
        requires :name, type: String
        requires :email, type: String
        requires :phone, type: String
        requires :flight_number, type: String
        requires :flight_departure_time, type: String
      end
      post do
        flight = Flight.find_by(number: params[:flight_number],
                                departure_time: Time.parse(params[:flight_departure_time]))

        user = User.find_or_initialize_by(name: params[:name],
                                          email: params[:email],
                                          phone: params[:phone])
        user.save!
        passenger = Passenger.create!(user_id: user.id,
                                      flight_id: flight.id)

        present passenger, with: Airport::Entities::Passenger
      end

      desc '5) A route to remove a person from a flight'
      params do
        requires :email, type: String
        requires :flight_number, type: String
        requires :flight_departure_time, type: String
      end
      delete do
        flight = Flight.find_by(number: params[:flight_number],
                                departure_time: Time.parse(params[:flight_departure_time]))

        user = User.find_by(email: params[:email])

        Passenger.find_by(flight_id: flight.id,
                          user_id: user.id).destroy
      end

      desc '7) A route to update a users phone number and email address'
      params do
        requires :email, type: String
        optional :new_email, type: String
        optional :new_phone, type: String
      end
      put do
        user = User.find_by(email: params[:email])

        update_params = {}
        update_params[:email] = params[:new_email] if params[:new_email]
        update_params[:phone] = params[:new_phone] if params[:new_phone]

        user.update(update_params)
        present user, with: Airport::Entities::User
      end
    end
  end
end
