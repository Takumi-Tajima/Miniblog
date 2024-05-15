class Users::ProfilesController < ApplicationController
  before_action :set_user

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.common.updated', model: 'プロフィール'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:biography, :blog_url)
  end
end
