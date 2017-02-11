class MailChimp
  include Singleton

  def initialize
    @mailchimp = Gibbon::Request.new(api_key: ENV.fetch('MAILCHIMP_API_KEY'))
  end

  def subscribe(member)
    list = @mailchimp.lists(ENV.fetch('MAILCHIMP_LIST_ID'))

    list.members.create(body: {
      email_address: member.email,
      status: "subscribed",
      merge_fields: {
        FNAME: member.first_name,
        LNAME: member.last_name,
        NAME: member.full_name
      }
    })
  end
end
