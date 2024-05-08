class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.default_order
  end

  def show; end

  def new
    @post = current_user.post.build
  end

  def edit; end

  def create
    @post = current_user.post.build(post_params)

    if @post.save
      redirect_to posts_path, notice: t('controllers.common.created', model: '投稿')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t('controllers.common.updated', model: '投稿'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: t('controllers.common.destroyed', model: '投稿'), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
