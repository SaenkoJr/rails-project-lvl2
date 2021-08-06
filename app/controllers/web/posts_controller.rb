# frozen_string_literal: true

module Web
  class PostsController < Web::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :set_post, only: %i[show edit update destroy]

    def index
      @posts = Post.includes(:creator)
    end

    def show
      @comments = @post.comments.order(created_at: :desc)
      @comment = @post.comments.build
      @user_like = @post.likes.find_by(user: current_user)
    end

    def new
      @post = Post.new
    end

    def edit; end

    def create
      @post = Post.new(post_params)
      @post.creator = current_user

      if @post.save
        redirect_to post_path(@post), notice: t('.success', scope: :flash)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        redirect_to post_path(@post), notice: t('.success', scope: :flash)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy

      redirect_to posts_path, notice: t('.success', scope: :flash)
    end

    private

    def set_post
      @post = Post.includes(:likes, :comments).find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :post_category_id)
    end
  end
end
