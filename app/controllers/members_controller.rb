class MembersController < ApplicationController
  # GET /members/new
  def new
    @member = Member.new
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to home_url, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :email)
    end
end
