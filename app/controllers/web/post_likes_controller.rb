# frozen_string_literal: true

module Web
  class PostLikesController < Web::ApplicationController
    before_action :authenticate_user!
    before_action :set_post

    def create
      like = @post.likes.build(user: current_user)

      unless like.save
        flash[:alert] = like.errors[:user].first
      end

      redirect_to @post
    end

    def destroy
      like = @post.likes.find_by(user: current_user)

      redirect_to @post if like.destroy
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end
