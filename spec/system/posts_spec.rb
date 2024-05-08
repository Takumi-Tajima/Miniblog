require 'rails_helper'

RSpec.describe 'ポスト機能', type: :system do
  describe 'ポストの表示機能' do
    let!(:post) { create(:post, content: 'hogehoge') }

    it 'トップページで表示されること' do
      visit root_path
      expect(page).to have_content 'hogehoge'
    end

    it 'ポスト詳細画面で表示されること' do
      visit post_path(post)
      expect(page).to have_content 'hogehoge'
    end
  end

  describe 'ポストの投稿機能' do
    context '自分の投稿の時' do
      let!(:user) { create(:user) }

      before do
        sign_in user
      end

      it 'ポストを投稿できること' do
        visit root_path
        click_on '新規投稿'
        expect(page).to have_current_path new_post_path
        fill_in '内容', with: 'fuga'
        expect do
          click_on '登録する'
          expect(page).to have_content '投稿を登録しました。'
        end.to change(user.posts, :count).by(1)
        expect(page).to have_content 'fuga'
      end

      it 'ポストを編集できること' do
        post = create(:post, content: 'foobar', user:)
        visit post_path(post)
        expect(page).to have_content 'foobar'
        click_on '編集'
        fill_in '内容', with: 'piyo'
        click_on '更新する'
        expect(page).to have_content '投稿を編集しました。'
        expect(page).not_to have_content 'foobar'
        expect(page).to have_content 'piyo'
      end

      it 'ポストを削除できること' do
        post = create(:post, content: 'MudaMuda', user:)
        visit post_path(post)
        expect(page).to have_content 'MudaMuda'
        expect do
          click_on '削除'
          expect(page).to have_content '投稿を削除しました。'
        end.to change(Post, :count).by(-1)
        expect(page).not_to have_content 'MudaMuda'
      end
    end

    context '他人の投稿の時' do
      let(:user) { create(:user) }
      let(:user2) { create(:user, name: 'Mac', email: 'sample@example.com') }
      let!(:post) { create(:post, user: user2) }

      before do
        sign_in user
      end

      it '編集、削除できないこと' do
        visit post_path(post)
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end
    end
  end
end
