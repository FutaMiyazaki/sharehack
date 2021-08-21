require 'rails_helper'

RSpec.describe Topic, type: :model do
  subject { user.topics.build(params) }
  let(:user) { create(:user) }
  let(:params) { title: title, description: description }
  let(:title) { '初めての一人暮らしにおすすめのアイテム' }
  let(:description) { '初めての一人暮らしを始める人向けに新生活をより便利で快適にするためのおすすめアイテムを教えてください！' }

  describe 'Association' do
    context 'with user model' do
      it 'N:1' do
        expect(Topic.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'with item model' do
      it '1:N' do
        expect(Topic.reflect_on_association(:items).macro).to eq :has_many
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end

  context 'user_idがnilの場合' do
    it '無効であること' do
      topic.user_id = nil
      expect(topic).to be_invalid
    end
  end

  describe 'title' do
    context 'nilの場合' do
      let(:title) { nil }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '空白の場合' do
      let(:title) { ' ' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '空文字の場合' do
      let(:title) { '' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '30文字以下の場合' do
      let(:title) { 'a' * 30 }
      it '有効であること' do
        expect(subject).to be_valid
      end
    end

    context '31文字以上の場合' do
      let(:title) { 'a' * 31 }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end
  end

  describe 'description' do
    context 'nilの場合' do
      let(:description) { nil }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '空白の場合' do
      let(:description) { ' ' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '空文字の場合' do
      let(:description) { '' }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end

    context '300文字以下の場合' do
      let(:description) { 'a' * 300 }
      it '有効であること' do
        expect(subject).to be_valid
      end
    end

    context '301文字以上の場合' do
      let(:description) { 'a' * 301 }
      it '無効であること' do
        expect(subject).to be_invalid
      end
    end
  end
end
