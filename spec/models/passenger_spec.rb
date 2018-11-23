require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'create Passenger' do
    context 'add passenger to full flight' do
      let(:flight) { create :flight }
      let!(:users) { create_list(:user, flight.capacity) }
      let(:new_user) { create :user }

      before :each do
        User.all.each { |user| Passenger.create(user_id: user.id, flight_id: flight.id) }
      end

      it { expect { Passenger.create!(user_id: new_user.id, flight_id: flight.id) }.to raise_exception }
    end

    context 'add passenger to flight' do
      let(:flight) { create :flight }
      let(:new_user) { create :user }

      before :each do
        Passenger.create!(user_id: new_user.id, flight_id: flight.id)
      end

      it { expect(Passenger.count).to eq 1 }
    end
  end
end
