# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:creator)
  end

  def show
    @comments = @post.post_comments.order(created_at: :desc)
    @likes = @post.post_likes
    @user_like = @likes.find_by(user: current_user)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to post_path(@post), notice: 'Post has been successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post has been successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path, notice: 'Post has been successfully deleted'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
