module Airport
  class Flights < Grape::API
    resource :flights do
      desc '3. A route to return all flights along with the the people on the flight' do
        success model: Airport::Entities::Flight
      end
      get do
        present Flight.joins(:passengers).all, with: Airport::Entities::Flight
      end

      desc '1. A route to create a flight. A flight has a date, number of people who can fit on the flight, and destination'
      params do
        requires :number, type: String
        requires :capacity, type: Integer
        requires :destination_airport_code, type: String
        requires :departure_time, type: String, desc: 'YYYY-MM-DD HH:mm'
      end
      post  do
        flight = Flight.create!(number: params[:number],
                                capacity: params[:capacity],
                                destination_airport_code: params[:destination_airport_code],
                                departure_time: Time.zone.parse(params[:departure_time]))

        present flight, with: Airport::Entities::Flight
      end

      desc '2. A route to remove a flight'
      params do
        requires :number, type: String
        requires :departure_time, type: String
      end
      delete  do
        present Flight.find_by(number: params[:number],
                               departure_time: Time.zone.parse(params[:departure_time])).destroy

      end

      desc '4. A route to update a flights date and destination'
      params do
        requires :number, type: String
        requires :departure_time, type: String
        optional :destination_airport_code, type: String
        optional :new_departure_time, type: String

      end
      put  do
        flight = Flight.find_by(number: params[:number],
                                departure_time: Time.parse(params[:departure_time]))
        update_params = {}
        update_params[:destination_airport_code] = params[:destination_airport_code] if params[:destination_airport_code]
        update_params[:departure_time] = Time.zone.parse(params[:new_departure_time]) if params[:new_departure_time]

        flight.update(update_params)
        present flight, with:Airport::Entities::Flight
      end
    end
  end
end
