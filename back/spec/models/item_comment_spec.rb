require 'rails_helper'

RSpec.describe ItemComment, type: :model do
  subject { user.item_comments.build(params) }
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:content) { '私も使ってます！' }
  let(:params) { { user_id: user.id, item_id: item.id, content: content } }

  describe 'Association' do
    context 'with user model' do
      it 'N:1' do
        expect(ItemComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'with item model' do
      it 'N:1' do
        expect(ItemComment.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end

  describe 'content' do
    context 'nilの場合' do
      let(:content) { nil }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空白の場合' do
      let(:content) { ' ' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '空文字の場合' do
      let(:content) { '' }
      it '無効であること' do
        expect(subject).to_not be_valid
      end
    end

    context '255文字より多い場合' do
      let(:content) { 'a' * 256 }
      it { is_expected.to_not be_valid }
    end
  end

end
