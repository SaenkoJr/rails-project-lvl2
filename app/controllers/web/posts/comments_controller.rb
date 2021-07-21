# frozen_string_literal: true

module Web
  module Posts
    class CommentsController < Web::ApplicationController
      before_action :authenticate_user!
      before_action :set_post
      before_action :set_comment, only: %i[edit update destroy]

      def edit; end

      def create
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
          redirect_to post_path(@post), notice: 'Comment has been successfully created'
        else
          redirect_to post_path(@post), alert: 'Comment has not been created'
        end
      end

      def update
        if @comment.update(comment_params)
          redirect_to post_path(@post), notice: 'Comment has been successfully updated'
        else
          render :edit, statsu: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy

        redirect_to post_path(@post), notice: 'Comment has been successfully deleted'
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
end
