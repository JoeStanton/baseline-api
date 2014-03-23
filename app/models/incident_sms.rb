class IncidentSMS
  def initialize
    @account_sid = ENV['TWILIO_SID']
    @auth_token = ENV['TWILIO_TOKEN']
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
  end

  def deliver
    @client.account.messages.create(:from => '441622523101', :to => '07584902989', :body => 'Test Message')
  end
end
