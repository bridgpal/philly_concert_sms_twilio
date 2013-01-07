require 'sinatra'
require 'twilio-ruby'

account_sid = ENV['TWILIO_ACCT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

def concert_find(band)
url = "http://xpn.org/concerts-events/concert-calendar"
data = Nokogiri::HTML(open(url))
string = "Sorry, but we could not find a show"
#parse concert data
concerts = data.css("tbody").css("tr")
concerts.each do |concerts|
	if concerts.css(".cell1").text.downcase.include? band.downcase
 	string = concerts.at_css(".cell1").text + ' | ' + concerts.at_css(".cell0").text + ' @ ' +concerts.at_css(".cell2").text 
	
	break
	end
	
end
string
end

get '/' do
  "philly concerts by sms test"


post '/sms' do
  concert = concert_find(params[:Body])
  twiml = Twilio::TwiML::Response.new do |r|
  	r.Sms concert
  end
  twiml.text
end

end