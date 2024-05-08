FactoryBot.define do
  factory :user do
    name { 'name' }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
