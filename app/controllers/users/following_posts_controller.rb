class Users::FollowingPostsController < ApplicationController
  def show
    @posts = Post.where(user_id: current_user.following_ids)
  end
end
