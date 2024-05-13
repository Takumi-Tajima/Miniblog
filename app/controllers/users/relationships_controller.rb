class Users::RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:follower_id])
    redirect_to request.referer || root_path
  end

  def destroy
    user = Relationship.find(params[:id]).following
    current_user.unfollow!(user.id)
    redirect_to request.referer || root_path, status: :see_other
  end
end
