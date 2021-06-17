require 'rails_helper'

RSpec.describe ItemLike, type: :model do
  let(:item_like) { create(:item_like) }

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

  context 'user_idおよびitem_idが存在する場合' do
    it '有効であること' do
      expect(item_like).to be_valid
    end
  end

  context 'user_idがnilの場合' do
    it '無効であること' do
      item_like.user_id = nil
      expect(item_like).to be_invalid
    end
  end

  context 'item_idがnilの場合' do
    it '無効であること' do
      item_like.item_id = nil
      expect(item_like).to be_invalid
    end
  end

end
