require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(params) }
  let(:params) { { name: name , email: email, password: password } }
  let(:name) { 'Miya' }
  let(:email) { 'test@sharehack.com' }
  let(:password) { 'password' }


  describe 'Association' do
    context 'with item model' do
      it '1:N' do
        expect(User.reflect_on_association(:items).macro).to eq :has_many
      end
    end
    context 'with item_like model' do
      it '1:N' do
        expect(User.reflect_on_association(:item_likes).macro).to eq :has_many
      end
    end
    context 'with item_comment model' do
      it '1:N' do
        expect(User.reflect_on_association(:item_comments).macro).to eq :has_many
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end

  context 'nameが無い場合' do
    let(:name) { nil }
    it { is_expected.to_not be_valid }
  end

  context 'nameが30文字より多い場合' do
    let(:name) { 'a' * 31 }
    it { is_expected.to_not be_valid }
  end

  context 'emailが無い場合' do
    let(:email) { nil }
    it { is_expected.to_not be_valid }
  end

  context 'passwordが無い場合' do
    let(:password) { nil }
    it { is_expected.to_not be_valid }
  end
end
