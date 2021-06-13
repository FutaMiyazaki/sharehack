require 'rails_helper'

RSpec.describe ItemTagMap, type: :model do
  subject { item.item_tag_maps.build(params) }
  let(:item) { create(:item) }
  let(:tag) { create(:tag) }
  let(:params) { { item_id: item.id, tag_id: tag.id } }

  describe 'Association' do
    context 'with item model' do
      it 'N:1' do
        expect(ItemTagMap.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end

    context 'with tag model' do
      it 'N:1' do
        expect(ItemTagMap.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end
end
