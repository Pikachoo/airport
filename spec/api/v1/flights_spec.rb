require 'rails_helper'

describe Airport::Flights do
  include Rack::Test::Methods

  def app
    Airport::Flights
  end

  describe 'GET /api/flights' do
    let(:flights) { creat_list :flight, 2 }
    let(:expected_response) { Flight.all.to_json }

    context 'returns all flights' do
      before do
        get '/api/flights'
      end

      it { expect(last_response.status).to eq(200) }
      it { expect(last_response.body).to eq(expected_response) }
    end
  end

  describe 'POST /api/fligths' do
    let(:body) do
      {
        number:  FFaker::Lorem.word,
        destination_airport_code: FFaker::Lorem.word,
        capacity: Random.rand(10..100),
        departure_time:  5.minutes.after
      }
    end

    context 'when there is no validation errors' do
      before do
        post '/api/flights', body, { 'Content-Type' => 'application/json' }
      end

      it { expect(last_response.status).to eq(201) }
    end
  end

  describe 'PUT /api/flights' do
    let!(:flight) { create :flight, departure_time:  '2018-11-23 20:25' }
    let(:body) do
      {
        number: flight.number,
        departure_time: flight.departure_time.to_s('YYYY-MM-DD HH::mm'),
        destination_airport_code: FFaker::Lorem.word
      }
    end

    context 'save flight' do
      before do
        put "/api/flights", body, { 'Content-Type' => 'application/json' }
      end

      it { expect(last_response.status).to eq(200) }
      it { expect(Flight.first.destination_airport_code).to eq(body[:destination_airport_code]) }
    end
  end

  describe 'DELETE /api/flights' do
    let!(:flight) { create :flight, departure_time:  '2018-11-23 20:25' }
    let(:body) do
      {
        number:  flight.number,
        departure_time:  flight.departure_time.to_s('YYYY-MM-DD HH::mm')
      }
    end


    context 'delete flight' do
      before do
        delete "/api/flights", body
      end

      it { expect(last_response.status).to eq(200) }
      it { expect(Flight.count).to eq(0) }
    end
  end
end
