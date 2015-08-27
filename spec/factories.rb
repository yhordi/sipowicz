FactoryGirl.define do
  factory :user do 
    name { Faker::Name.name }
    password_digest { Faker::Lorem.word }
  end
end

