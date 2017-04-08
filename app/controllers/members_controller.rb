class MembersController < ApplicationController
  # GET /members/new
  def new
    @member = Member.new
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    message = { notice: "You've been successfully added." }

    if @member.email =~ /.+@(student\.)?gsu.edu/ && @member.save
      begin
        MailChimp.instance.subscribe(@member)
      rescue Gibbon::MailChimpError
        @member.destroy
        message = { error: "Your data couldn't be saved. Try again later." }
      end
    else
      message = { error: "Please use a @student.gsu.edu or @gsu.edu email" }
    end

    redirect_to home_url, message
  end

  private
    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :email)
    end
end
