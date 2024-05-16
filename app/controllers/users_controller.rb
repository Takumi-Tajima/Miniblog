class UsersController < ApplicationController
  before_action :set_user
  before_action :redirect_profile_path_if_current_user

  def show; end

  def set_user
    @user = User.find(params[:id])
  end

  # ポスト一覧画面から自分のプロフィールリンクをクリックすると、自分のプロフィールページに遷移
  def redirect_profile_path_if_current_user
    redirect_to profile_path if current_user == @user
  end
end
