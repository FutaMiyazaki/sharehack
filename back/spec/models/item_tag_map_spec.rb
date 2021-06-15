require 'rails_helper'

RSpec.describe ItemTagMap, type: :model do
  let(:item_tag_map) { create(:item_tag_map) }

  context 'item_idおよびtag_idが存在する場合' do
    it '有効であること' do
      expect(item_tag_map).to be_valid
    end
  end

  context 'item_idがnilの場合' do
    it '無効であること' do
      item_tag_map.item_id = nil
      expect(item_tag_map).to be_invalid
    end
  end

  context 'tag_idがnilの場合' do
    it '無効であること' do
      item_tag_map.tag_id = nil
      expect(item_tag_map).to be_invalid
    end
  end
end
