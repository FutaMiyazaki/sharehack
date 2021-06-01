require 'rails_helper'

RSpec.describe ItemLike, type: :model do
  subject { user.item_likes.build(params) }
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:params) { { user_id: user.id, item_id: item.id } }

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end
end
