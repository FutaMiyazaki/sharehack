FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    link { "MyText" }
    price { 1 }
    user { nil }
  end
end
