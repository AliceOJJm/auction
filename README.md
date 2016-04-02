# auction
Rails-api server + AngularJS client auction social network app

To launch:

scp server/config/environments/test.rb.sample server/config/environments/test.rb
scp server/config/environments/development.rb.sample server/config/environments/test.rb
scp server/config/environments/production.rb.sample server/config/environments/test.rb
insert amazon s3 credentials

scp server/config/database.yml.sample server/config/database.yml


bundle install
rake db:setup

cd server && rails s
cd client && rails s -p 2000

localhost:2000
