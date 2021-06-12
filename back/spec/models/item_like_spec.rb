require 'rails_helper'

RSpec.describe ItemLike, type: :model do
  subject { user.item_likes.build(params) }
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:params) { { user_id: user.id, item_id: item.id } }

  describe 'Association' do
    context 'with user model' do
      it 'N:1' do
        expect(ItemLike.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'with item model' do
      it 'N:1' do
        expect(ItemLike.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end
end
