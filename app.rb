require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

get "/" do
  erb :home
end

get "/work" do
  erb :cookies
end

get "/mission" do
  erb :cakes
end


get "/services" do
  erb :muffins
end

get "/contact" do
  erb :newsletter
end

post "/contact" do
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]

  from = Email.new(email: 'messages@code25.com')
  to = Email.new(email: 'rashidharmand@gmail.com')
  subject = "New Message - Code 25"
  content = Content.new(type: 'text/html', 
    value: "<p><h2>Hi Geno,</h2>
    <br>
    A new message was submitted to Code 25 on #{Time.now.strftime("%A, %m/%d/%Y at %I:%M%p")}!</p>
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
    <strong>Message:</strong>
    <br>
    - #{@message}
    <br>
    <br>
    Regards,
    <br>
    - Code 25
    </p>")
  mail = Mail.new(from, subject, to, content)
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :thanks
end