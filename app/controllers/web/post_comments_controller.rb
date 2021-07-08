# frozen_string_literal: true

class Web::PostCommentsController < Web::ApplicationController
  before_action :authenticate_user!

  def new
    @comment = PostComment.new
  end

  def edit
    @comment = PostComment.find(params[:id])
  end

  def create
    @comment = PostComment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'Comment has been successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @comment = PostComment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to post_path(@comment.post_id), notice: 'Comment has been successfully updated'
    else
      render :edit, statsu: :unprocessable_entity
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy

    redirect_to post_path(@comment.post_id), notice: 'Comment has been successfully deleted'
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content)
  end
end
