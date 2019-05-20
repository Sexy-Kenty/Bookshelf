class PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @item = Item.find(@post.item_id)
    @user = User.find(@post.user_id)
  end

  def new
  end

  def create
    @item = Item.find(params[:post][:item_id])
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "口コミを投稿しました"
      redirect_to posts_path
    else
      flash.now[:danger] = "口コミの投稿に失敗しました"
      render 'items/items'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "口コミを更新しました"
      redirect_to posts_path
    else
      flash.now[:danger] = "口コミの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "口コミを削除しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :rate, :content, :item_id)
  end
end
