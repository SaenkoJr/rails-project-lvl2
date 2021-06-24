# frozen_string_literal: true

class Web::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Post has been successfully created'
      redirect_to post_path(@post)
    else
      flash[:notice] = 'Post has not been created'
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Post has been successfully updated'
      redirect_to post_path(@post)
    else
      flash[:notice] = 'Post has not been updated'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post has been successfully deleted'
      redirect_to posts_path
    else
      flash[:notice] = 'Post has not been deleted'
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
