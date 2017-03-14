https://www.udemy.com/build-a-photo-blog-with-ruby-on-rails/learn/v4/t/lecture/2605446?start=0
Build a Photo Blog with Ruby on Rails
https://github.com/jordanhudgens/photoflash

rails new photoflash
rake db:create
rails s -b $IP -p $PORT
rails g scaffold post title:string image:string description:text
rake db:migrate
bundle install --without production
rails g uploader photo

figaro install
->create  config/application.yml

chaper#2, Section #9: fileuploader parameters

config/initializers/fog.rb
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => "AWS",
    :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
  
  config.fog_directory = ENV['AWS_BUCKET']
  config.fog_public    = false
end

PROBLEM #1: 
Errno::ENOENT in PostsController#create
No such file or directory - identify
FIXED: 
I hadn't installed ImageMagick into my Cloud9 Rails IDE workstation! 
ran 'sudo apt-get update' in the workstation terminal, 
then 'sudo apt-get install ImageMagick' 

PROBLEM #2:
Excon::Error::BadRequest in PostsController#create 
The authorization header is malformed; the region 'us-east-1' is wrong; 
expecting 'us-west-1'
FIXED:
by creating new Bucket ucast-development1 selecting region us-east-1 
(https://console.aws.amazon.com/s3/home?region=us-east-1)

PROBLEM #3:
If git push code to GitHub and immediately got yelled at by AWS for exposing my secret keys
do you have any strategies for 'masking' the keys in source control? 
I need to pass the yml file to Heroku to run my application live 
and I can't do that without having that file in github. Thanks
SOLUTION:
Yes, you'll need to add your application.yml file to your gitignore file. 
If you ran the figaro generator it should have done that for you automatically. 
You can take a look at the source code for the project to see 
what your gitignore file should look like:
https://github.com/jordanhudgens/photoflash/blob/master/.gitignore
Check /vendor/.gitignore file should contained following line
# Ignore application configuration
/config/application.yml

next:#4-15:
Rendering images from the server onto the web application

#5-18 ------------ using rspec testing -----------------
add: gem 'rspec-rails', '~> 3.0'
$bundle install --without production
$rails generate rspec:install
->created spec/spec_helper.rb
          spec/rails_helper.rb
$bundle exec rspec
$rails g model User name:string email:string password:string
-> created 
   db/migrate/20170314034958_create_users.rb
   app/models/user.rb
   spec/models/user_spec.rb
$bundle exec rake db:migrate
$rails c
> User.create!(name: "Bob", email:"B@g,com", password:"13")
> ap User.all
edit user_spec.rb
$bundle exec rspec
->see 1 example, 0 failures

$bundle exec rspec  --format documentation
-> see what are you validate using rspec 
---------------------- Deploy to Heroku -----------------
$git add .
$git commit -m "Deploy to Heroku"
$heroku create udemyphotoblog
->see udemyphotoblog app in https://dashboard.heroku.com/apps 
$git remote -v
-> see: heroku  https://git.heroku.com/udemyphotoblog.git 
#following 4 lines from config/application.yml
#ref:http://stackoverflow.com/questions/27949158/heroku-missing-required-arguments-aws-access-key-id-aws-secret-access-key-f
$heroku config:set AWS_ACCESS_KEY_ID=xxx
$heroku config:set AWS_SECRET_ACCESS_KEY=xxx
$heroku config:set AWS_REGION=xxx
$heroku config:set AWS_BUCKET=xxx
$git push heroku master
$heroku run rake db:migrate
$heroku open
->https://udemyphotoblog.herokuapp.com/ working      
