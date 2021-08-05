# frozen_string_literal: true

require 'test_helper'

module Web
  class PostLikesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users('user_1')
      sign_in @user
    end

    test '#create' do
      post = posts('post_2')

      post post_likes_path(post)

      like = post.likes.find_by user: @user

      assert like
      assert_redirected_to post_path(post)
    end

    test '#destroy' do
      like = post_likes(:two)
      post = posts('post_2')

      assert_difference('PostLike.count', -1) do
        delete post_like_path(post, like)
      end

      assert_redirected_to post_path(post)
    end
  end
end
