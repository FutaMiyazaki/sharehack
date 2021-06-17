require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { item.tags.build(params) }
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
        expect(subject).to be_invalid
      end
    end

    context '空白の場合' do
      let(:name) { ' ' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '空文字の場合' do
      let(:name) { '' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '20文字以下の場合' do
      let(:name) { 'a' * 20 }
      it '有効であること' do
        expect(subject).to be_valid
      end
    end

    context '21文字以上の場合' do
      let(:name) { 'a' * 21 }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end
  end
end
