require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

get "/" do
  erb :home
end

get "/cookies" do
  erb :cookies
end

get "/cakes" do
  erb :cakes
end


get "/muffins" do
  erb :muffins
end

get "/newsletter" do
  erb :newsletter
end

post "/contact" do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @email = params[:email]

  from = Email.new(email: 'mj@mjbakery.com')
  to = Email.new(email: "#{@email}")
  subject = "#{@first_name} #{@last_name} + Mary Jane = Bliss!"
  content = Content.new(type: 'text/html', 
    value: "<p>Congratulations #{@first_name},
    <br>
    <br>
    You've been subscribed to Mary Jane's Bakery Catalog & we're thrilled to have you!</p>
    <br>
    Check out our treats!:
    <br>
    <br>
    <ul style='list-style-type:square'><h4>Cookies:</h4>
        <li>Cheba Chocolate Chip, 16 ~ Half Dozen</li>
        <li>Peanut Butter Kush, 16 ~ Half Dozen</li>
        <li>Sugar Cookies, $22 ~ Half Dozen</li>
        <li>Snickerdoodle Haze, $22 ~ Half Dozen</li>
        <li>Gingerbread OG, $30 ~ Half Dozen </li>
        <li>Moonrock Macadamia, $50 ~ Half Dozen</li>
    </ul>
    <br>
    <ul style='list-style-type:square'><h4>Cakes:</h4> 
        <li>Grandaddy Chocolate, $10 ~ Slice</li>
        <li>Red Velvet Purp, $10 ~ Slice</li>
        <li>Butter OG, $16 ~ 1 Slice</li>
        <li>Coconut Kryptonite, $16 ~ 1 Slice</li>
        <li>Cheese Quake, $20 ~ 1 Slice</li>
        <li>Atomic Marble, $20 ~ 1 Slice</li>
    </ul>
    <br>
    <ul style='list-style-type:square'><h4>Muffins:</h4> 
        <li>Chocolate Diesel, $16 ~ Half Dozen</li>
        <li>Blue Dragon, $16 ~ Half Dozen</li>
        <li>Banana Kush, $25 ~ Half Dozen</li>
        <li>Candy Apple, $25 ~ Half Dozen</li>
        <li>Cranberry Craze, $32 ~ Half Dozen</li>
        <li>Cinnamon Shock, $32 ~ Half Dozen</li>
    </ul>
    <br>
    <p>Our monthly newsletter will include new updates to Mary Jane's Bakery Catalog as well as articles about how you can help those negatively affected by the 'War On Drugs'.
    <br>
    <br>
    Best Wishes,
    <br>
    <br>
    - Mary Jane's Bakery
    </p>")
  mail = Mail.new(from, subject, to, content)
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :thanks
end