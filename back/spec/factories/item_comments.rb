FactoryBot.define do
  factory :item_comment do
    user { nil }
    item { nil }
    content { "MyString" }
  end
end
