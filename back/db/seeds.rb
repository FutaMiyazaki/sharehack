User.create!(
  name: 'ゲストユーザー'
  email: 'guest@sharehack.com',
  password: 'pwkkf3ST9uWW5XFe',
)

User.create!(
  name: ENV['RAILS_ADMIN_USERNAME'],
  email: ENV['RAILS_ADMIN_EMAIL'],
  password: ENV['RAILS_ADMIN_PASSWORD'],
  admin: true
)

[
  ['ライフハック'],
  ['買ってよかったもの'],
  ['ガジェット'],
  ['スマホ'],
  ['パソコン・周辺機器'],
  ['服・ファッション小物'],
  ['スマート家電'],
  ['お得情報'],
  ['美容・健康'],
  ['オーディオ'],
  ['カメラ'],
  ['自転車・バイク'],
  ['レビュー'],
  ['DIY'],
  ['格安SIM'],
  ['腕時計・スマートウォッチ'],
  ['本・コミック・雑誌'],
  ['ゲーム'],
  ['シューズ'],
  ['バッグ・財布']
].each do |name| Tag.create!({ name: name })
