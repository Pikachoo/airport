require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'remove Flight' do
    context 'remove flight with passengers' do
      let(:flight) { create :flight }
      let(:users) { create_list(:user, flight.capacity) }
      let!(:passengers) { users.each { |user| Passenger.create(user_id: user.id, flight_id: flight.id) } }
      let!(:passenger_count) { Passenger.count }

      it { expect{ flight.destroy }.to change{Passenger.count}.from(User.count).to(0) }
    end
  end
end
