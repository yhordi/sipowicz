FactoryGirl.define do
  factory :user do 
    name { Faker::Name.name }
    password { Faker::Lorem.string }
  end
end

