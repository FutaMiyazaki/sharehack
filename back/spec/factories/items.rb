FactoryBot.define do
  factory :item do
    name { 'ドラム式洗濯機' }
    description { '年120時間自由時間が増えます！' }
    link { "https://www.amazon.co.jp/%E3%82%A2%E3" }
    price { 100000 }
    association :user

    after(:create) do |item|
      create_list(:item_tag_map, 1, item: item, tag: create(:tag))
    end
  end
end
