require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { user.items.build(params) }
  let(:user) { create(:user) }
  let(:params) { { name: name, description: description, link: link, price: price } }
  let(:name) { 'ドラム式洗濯機' }
  let(:description) { '年120時間自由時間が増えます！' }
  let(:link) { 'https://www.amazon.co.jp/%E3%82%A2%E3' }
  let(:price) { 100000 }

  describe 'Association' do
    context 'with user model' do
      it 'N:1' do
        expect(Item.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'with item_comment model' do
      it '1:N' do
        expect(Item.reflect_on_association(:item_comments).macro).to eq :has_many
      end
    end
    context 'with item_like model' do
      it '1:N' do
        expect(Item.reflect_on_association(:item_likes).macro).to eq :has_many
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end

  context 'nameが無い場合' do
    let(:name) { nil }
    it '無効であること' do
      expect(subject).to_not be_valid
    end
  end

  context 'nameが30文字より多い場合' do
    let(:name) { 'a' * 31 }
    it { is_expected.to_not be_valid }
  end

  context 'descriptionが無い場合' do
    let(:description) { nil }
    it '無効であること' do
      expect(subject).to_not be_valid
    end
  end

  context 'descriptionが255文字より多い場合' do
    let(:description) { 'a' * 256 }
    it { is_expected.to_not be_valid }
  end

  context 'linkが不正な値の場合' do
    let(:link) { 'httpsharehack.com' }
    it '無効であること' do
      expect(subject).to_not be_valid
    end
  end

  context 'priceが無い場合' do
    let(:price) { nil }
    it '無効であること' do
      expect(subject).to_not be_valid
    end
  end
end
