User.create!(
  name: 'ゲストユーザー',
  email: 'guest@sharehack.com',
  password: 'pwkkf3ST9uWW5XFe'
)

User.create!(
  name: '管理者',
  email: 'sharehack-admin@sharehack.com',
  password: 'qavd7gnvdvx9',
  admin: true
)

Tag.create!(name: 'ライフハック')
Tag.create!(name: 'ガジェット')
Tag.create!(name: '買ってよかったもの')
Tag.create!(name: '買うべきもの')
Tag.create!(name: 'スマホ')
Tag.create!(name: 'パソコン・周辺機器')
Tag.create!(name: 'イヤホン')
Tag.create!(name: '家電')
Tag.create!(name: 'お得情報')
Tag.create!(name: '美容・健康')
