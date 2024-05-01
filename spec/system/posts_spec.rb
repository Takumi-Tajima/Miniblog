require 'rails_helper'

RSpec.describe 'ポスト機能', type: :system do
  describe 'ポストの表示機能' do
    let!(:post) { create(:post, contents: 'hogehoge') }

    it 'ポスト一覧画面で表示されること' do
      visit root_path
      expect(page).to have_content 'hogehoge'
    end

    it 'ポスト詳細画面で表示されること' do
      visit post_path(post)
      expect(page).to have_content 'hogehoge'
    end
  end

  describe 'ポストの投稿機能' do
    it 'ポストを投稿できること' do
      visit root_path
      click_on '新規投稿'
      expect(page).to have_current_path new_post_path
      fill_in '内容', with: 'fuga'
      expect do
        click_on '登録する'
        expect(page).to have_content '投稿を登録しました。'
      end.to change(Post, :count).by(1)
    end
  end
end
