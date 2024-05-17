require 'rails_helper'

RSpec.describe 'フォローしているユーザーの投稿一覧機能', type: :system do
  let(:user) { create(:user) }
  let(:jojo) { create(:user, name: 'jojo') }
  let(:dio) { create(:user, name: 'dio') }

  before do
    create(:post, user: jojo, content: 'oraora')
    create(:post, user: dio, content: 'mudamuda')
    sign_in user
    user.follow(jojo.id)
  end

  it 'フォローしているユーザーの投稿一覧が表示されること' do
    visit root_path
    expect(page).to have_content 'jojo'
    expect(page).to have_content 'oraora'
    expect(page).to have_content 'dio'
    expect(page).to have_content 'mudamuda'
    click_on 'フォロー中のユーザーの投稿'
    expect(page).to have_current_path following_posts_path
    expect(page).to have_content 'jojo'
    expect(page).to have_content 'oraora'
    expect(page).not_to have_content 'dio'
    expect(page).not_to have_content 'mudamuda'
  end
end
