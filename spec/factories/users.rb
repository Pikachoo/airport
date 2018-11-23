FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.first_name }
    phone { [FFaker::PhoneNumber.phone_calling_code, FFaker::PhoneNumber.short_phone_number].join.remove('-') }
  end
end
