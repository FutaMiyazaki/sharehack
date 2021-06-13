FactoryBot.define do
  factory :item_tag_map do
    association :item
    association :tag
  end
end
