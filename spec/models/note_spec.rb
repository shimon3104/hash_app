require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @note = FactoryBot.build(:note)
  end

  context 'ノート作成がうまくいかない時' do
    it 'userが紐付いていないと登録できない' do
      @note.user = nil
      @note.valid?
      expect(@note.errors.full_messages).to include('User must exist')
    end
  end
end
