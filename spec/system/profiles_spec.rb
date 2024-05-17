require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  describe 'プロフィール表示' do
    let(:user) { create(:user, name: 'takumi', email: 'takumi@example.com') }

    before do
      sign_in user
      create(:post, user:)
    end

    context '自分のプロフィール' do
      # - 自分のプロフィールを確認できること
      it '自分のプロフィールを確認できること' do
        visit root_path
        # TODO: ヘッダーのメニュー名をMyProfileにする
        click_on 'プロフィール'
        # TODO: ページタイトルをここに追記
        expect(page).to have_content 'takumi'
        expect(page).to have_content 'takumi@example.com'
      end

      # - 投稿一覧の自分の名前から、自分のプロフィールを確認できること
      it 'ポストの投稿一覧の投稿者名リンクから自分のプロフィールを確認できること' do
        visit root_path
        within('.footer-text') do
          click_on 'takumi'
        end
        # TODO: ページのタイトルをここに追記
        expect(page).to have_content 'takumi'
        expect(page).to have_content 'takumi@example.com'
      end
    end

    context '他人のプロフィール' do
      let(:other_user) { create(:user, name: 'dio', email: 'dio@example.com') }

      before do
        create(:post, user: other_user)
      end

      # - 他のユーザーのプロフィールを確認できること
      it '他のユーザーのプロフィールを確認できること' do
        visit root_path
        click_on 'dio'
        # TODO: ヘッダーのメニュー名をMyProfileすればここは通る
        expect(page).not_to have_content 'プロフィール'
        expect(page).to have_content 'dio'
        expect(page).to have_content 'dio@example.com'
      end
    end
  end

  describe 'プロフィール編集' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    # - 編集画面から自分の自己紹介文とブログURLを変更できること
    it '自分の自己紹介文とブログURLを変更できること' do
      visit root_path
      # TODO: MyProfileに変更する
      click_on 'プロフィール'
      # TODO: ページのタイトルをここに追記
      click_on '編集'
      fill_in '自己紹介', with: 'よろしくです'
      fill_in 'user_blog_url', with: 'google.com'
      click_on '更新する'
      expect(page).to have_content 'プロフィールを編集しました。'
      expect(page).to have_content 'よろしくです'
      expect(page).to have_content 'google.com'
    end
  end
end
