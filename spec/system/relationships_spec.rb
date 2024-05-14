require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    create(:post, user: other_user, content: 'こんばんは')
  end

  # （別案）
  # context 'ログインしているとき' do
  #   before do
  #     sign_in user
  #   end

  #   it '他のユーザーをフォローできること' do
  #     visit root_path
  #     expect(page).have_content 'こんばんは'
  #     expect do
  #       click_on 'フォロー'
  #       # フォロー後にuser.followingが増えていることを確認する
  #     end.to change(user.following, :count).by(1)
  #     # フォロー後にフォローボタンが非表示になっていることを確認する
  #     expect(page).not_to have_content 'フォロー'
  #     # フォロー後にフォロー解除ボタンが表示さていることを確認する
  #     expect(page).have_content 'フォロー解除'
  #   end

  #   it '他のユーザーをフォロー解除できること' do
  #     user.follow(other_user)
  #     visit root_path

  #     expect(page).to have_content 'こんばんは'
  #     # フォロー解除後にuser.followingが減っていることを確認する
  #     expect do
  #       click_on 'フォロー解除'
  #     end.to change(user.following, :count).by(-1)
  #     # フォロー解除後にフォロー解除ボタンが非表示になっている
  #     expect(page).not_to have_content 'フォロー解除'
  #     # フォロー解除後にフォローボタンが表示
  #     expect(page).to have_content 'フォロー'
  #   end
  # end

  context '自分が他ユーザーをフォローしてないとき' do
    before do
      sign_in user
    end

    it '他のユーザーをフォローできること' do
      visit root_path
      expect(page).to have_content 'こんばんは'
      expect do
        click_on 'フォロー'
        expect(page).to have_content 'フォロー解除'
      end.to change(user.followings, :count).by(1)
      expect(page).not_to have_content('フォロー', exact: true)
    end
  end

  context '自分が他ユーザーをフォローしているとき' do
    before do
      sign_in user
      user.follow(other_user.id)
    end

    it '他のユーザーをフォロー解除できること' do
      visit root_path
      expect(page).to have_content 'こんばんは'
      expect do
        click_on 'フォロー解除'
        expect(page).to have_content 'フォロー'
      end.to change(user.followings, :count).by(-1)
      expect(page).not_to have_content 'フォロー解除'
    end
  end

  context '未ログインのとき' do
    it 'フォローボタンが表示されないこと' do
      visit root_path

      expect(page).to have_content 'こんばんは'
      expect(page).not_to have_content 'フォロー'
      expect(page).not_to have_content 'フォロー解除'
    end
  end
end
