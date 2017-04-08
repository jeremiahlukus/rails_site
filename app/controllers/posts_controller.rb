class PostsController < ApplicationController
  def index
    @posts = Post.published
  end

  def show
    @post = Post.find_by(name: "#{params[:name]}.md")
  end
end
