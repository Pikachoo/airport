FactoryBot.define do
  factory :flight do
    number { FFaker::Lorem.word }
    destination_airport_code { FFaker::Lorem.word }
    capacity { Random.rand(10..100) }
    departure_time { 5.minutes.after }
  end
end
