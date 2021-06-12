FactoryBot.define do
  factory :item_comment do
    association :user
    association :item
    content { "私も使ってます！" }
  end
end
