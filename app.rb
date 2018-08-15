require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

get "/" do
  erb :home
end

get "/our-team" do
  erb :thanks
end

get "/faq" do
  erb :faq
end

get "/lead-gen" do
  erb :cookies
end

get "/web-design" do
  erb :web_design
end

get "/content" do
  erb :muffins
end

get "/case-studies" do
  erb :case_studies
end

get "/contact" do
  erb :newsletter
end

post "/contact" do
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]
  @best_time_to_talk = params[:best_time_to_talk]

  from = Email.new(email: 'messages@code25.com')
  to = Email.new(email: 'geno.miller026@gmail.com')
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
    <strong>Best Time to Talk:</strong>
    <br>
    - #{@best_time_to_talk}
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