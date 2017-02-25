class PagesController < ApplicationController
  # GET /
  def home
    @member = Member.new
  end

  def about
  end
end
