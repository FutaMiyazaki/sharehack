User.create!(
  name: ENV['GUEST_NAME'],
  email: ENV['GUEST_EMAIL'],
  password: ENV['GUEST_PASSWORD']
)

User.create!(
  name: ENV['ADMIN_NAME'],
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  admin: true
)

Tag.create!(name: 'ライフハック')
Tag.create!(name: '買ってよかったもの')
Tag.create!(name: 'ガジェット')
Tag.create!(name: 'スマホ')
Tag.create!(name: 'パソコン・周辺機器')
Tag.create!(name: 'イヤホン')
Tag.create!(name: '家電')
Tag.create!(name: '新生活')
Tag.create!(name: 'お得情報')
Tag.create!(name: '美容・健康')
