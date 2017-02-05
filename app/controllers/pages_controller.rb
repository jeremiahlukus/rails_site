class PagesController < ApplicationController
  # GET /
  def home
    @member = Member.new
  end
end
