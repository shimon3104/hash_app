require 'rails_helper'

RSpec.describe NotesTag, type: :model do
  describe '#create' do
    before do
      @notes_tag = FactoryBot.build(:notes_tag)
    end

    context 'ノート作成がうまくいく時' do
      it '全ての項目が存在すれば登録できる' do
        expect(@notes_tag).to be_valid
      end
    end

    context 'ノート作成がうまくいかない時' do
      it 'titleが空では登録できない' do
        @notes_tag.title = ''
        @notes_tag.valid?
        expect(@notes_tag.errors.full_messages).to include("Title can't be blank")
      end

      it 'textが空では登録できない' do
        @notes_tag.text = ''
        @notes_tag.valid?
        expect(@notes_tag.errors.full_messages).to include("Text can't be blank")
      end

      it 'nameが空では登録できない' do
        @notes_tag.name = ''
        @notes_tag.valid?
        expect(@notes_tag.errors.full_messages).to include("Name can't be blank")
      end

      it 'titleが50文字以上だと登録できない' do
        @notes_tag.title = '123456789012345678901234567890123456789012345678901'
        @notes_tag.valid?
        expect(@notes_tag.errors.full_messages).to include("Title is too long (maximum is 50 characters)")
      end
    end
  end
end
