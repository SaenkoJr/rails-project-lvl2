# frozen_string_literal: true

require 'test_helper'

class Web::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users('user_1')
    sign_in @user
  end

  test '#index' do
    get posts_path
    assert_response :success
  end

  test '#new' do
    get new_post_path
    assert_response :success
  end

  test '#show' do
    post = posts('post_1')
    get post_path(post)
    assert_response :success
  end

  test '#edit' do
    post = posts('post_1')
    get edit_post_path(post)
    assert_response :success
  end

  test '#create' do
    category = post_categories('category_2')
    attrs = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      category_id: category.id
    }

    post posts_path, params: { post: attrs }

    post = Post.find_by(title: attrs[:title])

    assert post
    assert_redirected_to post_path(post)
    assert_equal post.creator, @user
    assert_equal post.category, category
  end

  test '#update' do
    old_post = posts('post_1')
    category = post_categories('category_0')
    attrs = {
      title: Faker::Lorem.sentence,
      category_id: category.id
    }

    patch post_path(old_post), params: { post: attrs }

    post = Post.find(old_post[:id])

    assert post
    assert_redirected_to post_path(post)
    assert_not_equal post.title, old_post.title
    assert_not_equal post.category, old_post.category
  end

  test '#destroy' do
    post = posts('post_1')

    assert_difference('Post.count', -1) do
      delete post_path(post)
    end

    assert_redirected_to posts_path
  end
end
