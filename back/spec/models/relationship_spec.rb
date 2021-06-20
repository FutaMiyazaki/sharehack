require 'rails_helper'

RSpec.describe Relationship, type: :model do
  subject { user.relationships.build(params) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:params) { { user_id: user.id, follow_id: other_user.id } }

  context '全てのパラメータが正しい場合' do
    it { is_expected.to be_valid }
  end
end
