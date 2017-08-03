class PagesController < ApplicationController
  # GET /
  def home
    @member = Member.new
  end

  def about
  end

  def calendar
  end

  def events
  	@events = Event.all
  end
end
