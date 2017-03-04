class PostsController < ApplicationController
  def index
    @posts = Post.all.sort { |a, b| b.date <=> a.date }
  end

  def show
    @post = Post.find_by(name: "#{params[:name]}.md")
  end
end
