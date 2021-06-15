# require 'rails_helper'

# RSpec.describe ItemTagMap, type: :model do
#   # let(:item) { create(:item) }
#   # let(:tag) { create(:tag) }
#   let(:item_tag_map) { create(:item_tag_map) }

#   describe 'Association' do
#     context 'with item model' do
#       it 'N:1' do
#         expect(ItemTagMap.reflect_on_association(:item).macro).to eq :belongs_to
#       end
#     end

#     context 'with tag model' do
#       it 'N:1' do
#         expect(ItemTagMap.reflect_on_association(:tag).macro).to eq :belongs_to
#       end
#     end
#   end

#   context 'item_idおよびtag_idがnilの場合' do
#     it "有効であること" do
#       expect(item_tag_map).to be_valid
#     end
#   end

#   context 'item_idがnilの場合' do
#     it "無効であること" do
#       item_tag_map.item_id = nil
#       expect(item_tag_map).to be_invalid
#     end
#   end

#   context "tag_idがnilの場合" do
#     it "無効であること" do
#       item_tag_map.tag_id = nil
#       expect(item_tag_map).to be_invalid
#     end
#   end
# end
