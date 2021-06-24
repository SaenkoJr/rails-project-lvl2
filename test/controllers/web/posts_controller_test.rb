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
      post_category_id: category.id
    }

    post posts_path, params: { post: attrs }

    post = Post.find_by(title: attrs[:title])

    assert post
    assert_redirected_to post_path(post)
    assert_equal post.post_category, category
    assert_equal post.creator_id, @user.id
  end

  test '#update' do
    old_post = posts('post_1')
    category = post_categories('category_0')
    attrs = {
      title: Faker::Lorem.sentence,
      post_category_id: category.id
    }

    patch post_path(old_post), params: { post: attrs }

    post = Post.find(old_post[:id])

    assert post
    assert_redirected_to post_path(post)
    assert_not_equal post.title, old_post.title
    assert_not_equal post.post_category, old_post.post_category
  end

  test '#destroy' do
    post = posts('post_1')

    delete post_path(post)

    assert_redirected_to posts_path
    assert_not_equal posts.count, Post.count
  end
end
