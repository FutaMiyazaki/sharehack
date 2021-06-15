FactoryBot.define do
  factory :item_comment do
    association :user
    association :item

    sequence(:content) { |n| "comment-#{n}" }
  end
end
