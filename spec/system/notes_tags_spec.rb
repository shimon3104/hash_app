require 'rails_helper'

RSpec.describe "ノートの新規作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @note = FactoryBot.build(:note)
    @tag = FactoryBot.build(:tag)
  end

  context 'ノートの新規作成ができるとき'do
    it 'ログインしたユーザーはノートの新規作成ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへのリンクがあることを確認する
      expect(page).to have_content("#{@user.nickname}のページへ")
      # ユーザーページに移動する
      visit user_path(@user.id)
      # ノートの新規作成ページへのリンクがあることを確認する
      expect(page).to have_content('ノートを作成する')
      # ノートの新規作成ページに移動する
      visit new_note_path
      # フォームに情報を入力する
      fill_in 'notes_tag_title', with: @note.title
      fill_in 'notes_tag_text', with: @note.text
      fill_in 'notes_tag_name', with: @tag.name
      find("#notes_tag_status").find("option[value='非公開']").select_option
      # 送信するとNoteモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Note.count }.by(1)
      # ユーザーページに遷移することを確認する
      expect(current_path).to eq user_path(@user.id)
      # ユーザーページに先ほど作成したノートが存在することを確認する
      expect(page).to have_content(@note.title)
    end
  end
  
  context 'ノートの新規作成ができないとき'do
    it 'ログインしていないとノートの新規作成ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # ユーザーページへのリンクがない
      expect(page).to have_no_content("#{@user.nickname}のページへ")
    end
  end
end

RSpec.describe "ノートの編集", type: :system do
  before do
    @note1 = FactoryBot.create(:note, :note_with_tags)
    @tag1_id = @note1.tags.ids
    @tag1 = Tag.find(@tag1_id)
    @note2 = FactoryBot.create(:note, :note2_with_tags)
  end

  context 'ノートの編集ができるとき' do
    it 'ログインしたユーザーはユーザーページから自分が作成したノートの編集ができる' do
      # ノート1を作成したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note1.user.email
      fill_in 'Password', with: @note1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへのリンクがあることを確認する
      expect(page).to have_content("#{@note1.user.nickname}のページへ")
      # ユーザーページに移動する
      visit user_path(@note1.user.id)
      # ユーザーページにノート1が存在することを確認する
      expect(page).to have_content(@note1.title)
      # ノート1の編集ページに移動する
      visit edit_note_path(@note1.id)
      # すでに作成済みの内容がフォームに入っていることを確認する
      expect(
        find('#notes_tag_title').value
      ).to eq @note1.title
      expect(
        find('#notes_tag_text').value
      ).to eq @note1.text
      expect(
        find('#notes_tag_name').value
      ).to eq @tag1.pluck(:name)[0]  
      expect(
        find("#notes_tag_status").value
      ).to eq @note1.status
      # ノート１の内容を編集する
      fill_in 'notes_tag_title', with: "title_test"
      fill_in 'notes_tag_text', with: "text_test"
      fill_in 'notes_tag_name', with: "tag_name_test"
      find("#notes_tag_status").find("option[value='非公開']").select_option
      # 編集してもNoteモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Note.count }.by(0)
      # ユーザーページに遷移したことを確認する
      expect(current_path).to eq user_path(@note1.user.id)
      # ユーザーページに先ほど投稿した内容のノートが存在することを確認する
      expect(page).to have_content("title_test")
    end
  end

  context 'ノートの編集ができないとき' do
    it 'ログインしたユーザーはユーザーページから自分以外が作成したノートの編集画面には遷移できない' do
      # ノート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note1.user.email
      fill_in 'Password', with: @note1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへのリンクがあることを確認する
      expect(page).to have_content("#{@note1.user.nickname}のページへ")
      # ユーザーページに移動する
      visit user_path(@note1.user.id)
      # ユーザーページにノート2が存在しないことを確認する
      expect(page).to have_no_content(@note2.title)
    end

    it 'ログインしていないとノートの編集画面には遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページにユーザーページへのリンクがないことを確認する
      expect(page).to have_no_content("#{@note1.user.nickname}のページへ")
    end
  end
end

RSpec.describe "ノートの削除", type: :system do
  before do
    @note1 = FactoryBot.create(:note, :note_with_tags)
    @tag1_id = @note1.tags.ids
    @tag1 = Tag.find(@tag1_id)
    @note2 = FactoryBot.create(:note, :note2_with_tags)
  end

  context 'ノートの削除ができるとき' do
    it 'ログインしたユーザーは自らが作成したノートの削除ができる' do
      # ノート1を作成したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note1.user.email
      fill_in 'Password', with: @note1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへのリンクがあることを確認する
      expect(page).to have_content("#{@note1.user.nickname}のページへ")
      # ユーザーページに移動する
      visit user_path(@note1.user.id)
      # ユーザーページにノート1が存在することを確認する
      expect(page).to have_content(@note1.title)
      # ノート1の編集ページに移動する
      visit edit_note_path(@note1.id)  
      # すでに作成済みの内容がフォームに入っていることを確認する
      expect(
        find('#notes_tag_title').value
      ).to eq @note1.title
      expect(
        find('#notes_tag_text').value
      ).to eq @note1.text
      expect(
        find('#notes_tag_name').value
      ).to eq @tag1.pluck(:name)[0]  
      expect(
        find("#notes_tag_status").value
      ).to eq @note1.status
      # ノート１の編集ページに「ノートの削除」ボタンがあることを確認する
      expect(page).to have_content("ノートの削除")
      # ノート1を削除するとレコードの数が1減ることを確認する
      expect{
        click_on "ノートの削除"
      }.to change { Note.count }.by(-1)
      # ユーザーページに遷移したことを確認する
      visit user_path(@note1.user.id)
      # ページにはノート1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@note1.title}")
    end
  end

  context 'ノートの削除ができないとき' do
    it 'ログインしたユーザーは自分以外が作成したノートの削除ができない' do
      # ノート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note1.user.email
      fill_in 'Password', with: @note1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへのリンクがあることを確認する
      expect(page).to have_content("#{@note1.user.nickname}のページへ")
      # ユーザーページに移動する
      visit user_path(@note1.user.id)
      # ユーザーページにノート2が存在しないことを確認する
      expect(page).to have_no_content(@note2.title)
    end

    it 'ログインしていないとノートの削除ができない' do
      # トップページに移動する
      visit root_path
      # トップページにユーザーページへのリンクがないことを確認する
      expect(page).to have_no_content("#{@note1.user.nickname}のページへ")
    end
  end
end

RSpec.describe 'ノートの公開', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @note = FactoryBot.build(:note)
    @tag = FactoryBot.build(:tag)
  end

  context 'ノートが公開されるとき' do
    it 'statusを「公開する」にしたノートは公開ノート一覧に表示される' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ノートの新規作成ページへ移動する
      expect(page).to have_content("#{@user.nickname}のページへ")
      visit user_path(@user.id)
      expect(page).to have_content('ノートを作成する')
      visit new_note_path
      # フォームに情報を入力しstatusを「公開する」にする
      fill_in 'notes_tag_title', with: @note.title
      fill_in 'notes_tag_text', with: @note.text
      fill_in 'notes_tag_name', with: @tag.name
      find("#notes_tag_status").find("option[value='公開する']").select_option
      # 送信しユーザーページに遷移する
      expect{
        find('input[name="commit"]').click
      }.to change { Note.count }.by(1)
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_content(@note.title)
      # 公開ノート一覧ページに移動する
      visit publish_notes_path
      # 公開ノート一覧ページに新規作成したノートがあることをを確認する
      expect(page).to have_content(@note.title)
    end
  end

  context 'ノートが公開されないとき' do
    it 'statusを「非公開」にしたノートは公開ノート一覧ページに表示されない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ノートの新規作成ページへ移動する
      expect(page).to have_content("#{@user.nickname}のページへ")
      visit user_path(@user.id)
      expect(page).to have_content('ノートを作成する')
      visit new_note_path
      # フォームに情報を入力しstatusを「非公開」にする
      fill_in 'notes_tag_title', with: @note.title
      fill_in 'notes_tag_text', with: @note.text
      fill_in 'notes_tag_name', with: @tag.name
      find("#notes_tag_status").find("option[value='非公開']").select_option
      # 送信しユーザーページに遷移する
      expect{
        find('input[name="commit"]').click
      }.to change { Note.count }.by(1)
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_content(@note.title)
      # 公開ノート一覧ページに移動する
      visit publish_notes_path
      # 公開ノート一覧ページに新規作成したノートがないことをを確認する
      expect(page).to have_no_content(@note.title)
    end
  end
end

RSpec.describe "ノートの詳細", type: :system do
  before do
    @note1 = FactoryBot.create(:note, :note_with_tags)
    @tag1_id = @note1.tags.ids
    @tag1 = Tag.find(@tag1_id)
    @note2 = FactoryBot.create(:note, :note2_with_tags)
  end

  context 'ユーザーによって公開ノート一覧ページからのページ遷移先が変化する' do
    it 'ログインしたユーザーは公開ノート一覧ページから自分が作成したノートの編集画面に遷移する' do
      # ノート1を作成したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note1.user.email
      fill_in 'Password', with: @note1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 公開ノート一覧ページに移動する
      visit publish_notes_path
      # 公開ノート一覧ページにノート１があることをを確認する
      expect(page).to have_content(@note1.title)
      # ノート１のタイトルをクリックする
      click_on @note1.title
      # ノート1の編集ページに遷移したことを確認する
      expect(current_path).to eq edit_note_path(@note1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#notes_tag_title').value
      ).to eq @note1.title
      expect(
        find('#notes_tag_text').value
      ).to eq @note1.text
      expect(
        find('#notes_tag_name').value
      ).to eq @tag1.pluck(:name)[0]  
      expect(
        find("#notes_tag_status").value
      ).to eq @note1.status
    end

    it 'ログインしたユーザーは公開ノート一覧ページから自分が作成していないノートの詳細画面に遷移する' do
      # ノート２を作成したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @note2.user.email
      fill_in 'Password', with: @note2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 公開ノート一覧ページに移動する
      visit publish_notes_path
      # 公開ノート一覧ページにノート１があることをを確認する
      expect(page).to have_content(@note1.title)
      # ノート１のタイトルをクリックする
      click_on @note1.title
      # ノート1の詳細ページに遷移したことを確認する
      expect(current_path).to eq note_path(@note1.id)
      # ノート１の詳細ページにノート１の情報が表示されていることを確認する
      expect(page).to have_content(@note1.title)
      expect(page).to have_content(@note1.text)
      expect(page).to have_content(@tag1.pluck(:name)[0])
      # ノート１の詳細ページに「保存する」ボタンがないことを確認する
      expect(page).to have_no_content('保存する')
    end
  end
end