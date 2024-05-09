FactoryBot.define do
  factory :user do
    name { 'name' }
    email { Faker::Internet.unique.email }
    password { 'password123' }
  end
end
