FactoryBot.define do
  factory :post do
    user
    content { 'hogehoge' }
  end
end
