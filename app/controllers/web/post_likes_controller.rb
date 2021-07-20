# frozen_string_literal: true

class Web::PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    like = @post.post_likes.build(user: current_user)
    unless like.save
      flash[:alert] = like.errors[:base].first.full_message
    end

    redirect_to @post
  end

  def destroy
    like = @post.post_likes.find_by(user: current_user)

    redirect_to @post if like.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
