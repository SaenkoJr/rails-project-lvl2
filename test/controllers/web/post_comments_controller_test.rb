# frozen_string_literal: true

require 'test_helper'

module Web
  class PostCommentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @post = posts('post_1')
      @user = users('user_1')
      sign_in @user
    end

    test '#edit' do
      comment = post_comments(:one)
      get edit_post_comment_path(@post, comment)
      assert_response :success
    end

    test '#create' do
      attrs = { content: Faker::Lorem.sentence }
      post post_comments_path(@post), params: { post_comment: attrs }

      comment = PostComment.find_by(content: attrs[:content])

      assert comment
      assert_redirected_to post_path(@post)
      assert_equal comment[:content], attrs[:content]
      assert_equal comment.post, @post
      assert_equal comment.user, @user
    end

    test '#create (replies)' do
      comment = post_comments(:one)
      attrs = { content: Faker::Lorem.sentence, parent_id: comment.id }
      post post_comments_path(@post), params: { post_comment: attrs }

      reply = PostComment.find_by(content: attrs[:content])

      assert reply
      assert_redirected_to post_path(@post)
      assert_equal reply[:content], attrs[:content]
      assert_equal reply.post, @post
      assert_equal reply.user, @user
      assert_equal reply.parent, comment
    end

    test '#update' do
      old_comment = post_comments(:one)
      attrs = { content: Faker::Lorem.sentence }
      patch post_comment_path(@post, old_comment), params: { post_comment: attrs }

      comment = PostComment.find(old_comment.id)

      assert comment
      assert_redirected_to post_path(@post)
      assert_equal comment[:content], attrs[:content]
    end

    test '#destroy' do
      comment = post_comments(:one)

      assert_difference('PostComment.count', -1) do
        delete post_comment_path(@post, comment)
      end

      assert_redirected_to post_path(@post)
    end
  end
end
