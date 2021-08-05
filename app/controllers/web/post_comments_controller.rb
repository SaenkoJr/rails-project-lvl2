# frozen_string_literal: true

module Web
  class PostCommentsController < Web::ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :set_comment, only: %i[edit update destroy]

    def edit; end

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to post_path(@post), notice: t('.success', scope: :flash)
      else
        redirect_to post_path(@post), alert: t('.error', scope: :flash)
      end
    end

    def update
      if @comment.update(comment_params)
        redirect_to post_path(@post), notice: t('.success', scope: :flash)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment.destroy

      redirect_to post_path(@post), notice: t('.success', scope: :flash)
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
