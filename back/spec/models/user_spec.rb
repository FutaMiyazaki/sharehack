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

    context '30文字より多い場合' do
      let(:name) { 'a' * 31 }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'email' do
    context 'nilの場合' do
      let(:email) { nil }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空白の場合' do
      let(:email) { ' ' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空文字の場合' do
      let(:email) { '' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'password' do
    context 'nilの場合' do
      let(:password) { nil }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空白の場合' do
      let(:password) { ' ' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空文字の場合' do
      let(:password) { '' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end
  end
end
