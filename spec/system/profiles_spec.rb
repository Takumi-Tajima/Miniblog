require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  describe 'プロフィール表示' do
    context '自分のプロフィール' do
      # - 自分のプロフィールを確認できること
      it '自分のプロフィールを確認できること' do
      end

      # - 投稿一覧の自分の名前から、自分のプロフィールを確認できること
      it 'ポストの投稿一覧の投稿者名リンクから自分の投稿を確認できること' do
      end
    end

    context '他人のプロフィール' do
      # - 他のユーザーのプロフィールを確認できること
      it '他のユーザーのプロフィールを確認できること' do
      end
    end
  end

  describe 'プロフィール編集' do
    # - 編集画面から自分の自己紹介文とブログURLを変更できること
    it '自分の自己紹介文とブログURLを変更できること' do
    end
  end
end
