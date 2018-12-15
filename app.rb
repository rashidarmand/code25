require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

get "/" do
  erb :home
end

# get "/our-team" do
#   erb :thanks
# end

get "/faq" do
  erb :faq
end

# get "/lead-gen" do
#   erb :lead_gen
# end

get "/web-design" do
  erb :web_design
end

# get "/content" do
#   erb :lead_gen
# end

get "/case-studies" do
  erb :case_studies
end

get "/contact" do
  erb :contact
end

post "/contact" do
  @name = params[:name]
  @email = params[:email]
  @company = params[:company]
  @message = params[:message]
  @services = params[:services].join(', ')
  @first_choice = params[:fc_hr] + ':' + params[:fc_min] + ' ' + params[:fc_am_pm]
  @second_choice = params[:sc_hr] + ':' + params[:sc_min] + ' ' + params[:sc_am_pm]

  from = Email.new(email: 'messages@code25.com')
  to = Email.new(email: 'rashidharmand@gmail.com')
  subject = "New Message - Code 25"
  content = Content.new(type: 'text/html', 
    value: 
    "<p>
      <h2>Hi Rashid,</h2>
      <br>
      A new message was submitted to Code 25 on #{Time.now.strftime("%A, %m/%d/%Y at %I:%M%p")}!
    </p>
    <br>
    <strong>Name:</strong>
    <br>
    - #{@name}
    <br>
    <br>
    <strong>Email:</strong>
    <br>
    - #{@email}
    <br>
    <br>
    <strong>Company:</strong>
    <br>
    - #{@company}
    <br>
    <br>
    <strong>Best Time To Call:</strong>
    <br>
    - First Choice: #{@first_choice}
    <br>
    - Second Choice: #{@second_choice}
    <br>
    <br>
    <strong>Services:</strong>
    <br>
    - #{@services}
    <br>
    <br>
    <strong>Message:</strong>
    <br>
    - #{@message}
    <br>
    <br>
    Regards,
    <br> <br>
    - Code 25
    </p>")
  mail = Mail.new(from, subject, to, content)
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :thanks
end