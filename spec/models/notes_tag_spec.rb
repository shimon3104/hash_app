require 'rails_helper'

RSpec.describe NotesTag, type: :model do
  describe '#create' do
    before do
      @note = FactoryBot.build(:note)
      @tag = FactoryBot.build(:tag)
    end

    context 'ノート作成がうまくいく時' do
      it '全ての項目が存在すれば登録できる' do
        expect(@note).to be_valid
        expect(@tag).to be_valid
      end
    end

    context 'ノート作成がうまくいかない時' do
      it 'titleが空では登録できない' do
        @note.title = ''
        @note.valid?
        expect(@note.errors.full_messages).to include("Title can't be blank")
      end

      it 'textが空では登録できない' do
        @note.text = ''
        @note.valid?
        expect(@note.errors.full_messages).to include("Text can't be blank")
      end

      it 'nameが空では登録できない' do
        @tag.name = ''
        @tag.valid?
        expect(@tag.errors.full_messages).to include("Name can't be blank")
      end

      it 'titleが50文字以上だと登録できない' do
        @note.title = '123456789012345678901234567890123456789012345678901'
        @note.valid?
        expect(@note.errors.full_messages).to include('Title is too long (maximum is 50 characters)')
      end

      it 'userが紐付いていないと登録できない' do
        @note.user = nil
        @note.valid?
        expect(@note.errors.full_messages).to include('User must exist')
      end
    end
  end
end
