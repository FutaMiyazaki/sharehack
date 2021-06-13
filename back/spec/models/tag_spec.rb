require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { item.tags.build(params) }
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:params) { { name: name } }
  let(:name) { '新生活' }

  describe 'Association' do
    context 'with item_tag_map model' do
      it '1:N' do
        expect(Tag.reflect_on_association(:item_tag_maps).macro).to eq :has_many
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end

  describe 'name' do
    context 'nilの場合' do
      let(:name) { nil }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空白の場合' do
      let(:name) { ' ' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空文字の場合' do
      let(:name) { '' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '20文字より多い場合' do
      let(:name) { 'a' * 21 }
      it { is_expected.to_not be_valid }
    end
  end

end
