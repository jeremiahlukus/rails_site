class PagesController < ApplicationController
  include PagesHelper
  # GET /
  def home
    @member = Member.new
  end

  def about
  end

  def calendar
  end
end
