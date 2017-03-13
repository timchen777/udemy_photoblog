https://www.udemy.com/build-a-photo-blog-with-ruby-on-rails/learn/v4/t/lecture/2605446?start=0
Build a Photo Blog with Ruby on Rails

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
