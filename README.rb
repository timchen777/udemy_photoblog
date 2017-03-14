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
