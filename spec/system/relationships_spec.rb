require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    create(:post, user: other_user, content: 'こんばんは')
  end

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
      expect(page).not_to have_content('フォロー', exact: true)
      expect(page).not_to have_content 'フォロー解除'
    end
  end
end
