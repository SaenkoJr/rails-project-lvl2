# frozen_string_literal: true

class Web::HomeController < ApplicationController
  def index
    @posts = Post.all
  end
end
