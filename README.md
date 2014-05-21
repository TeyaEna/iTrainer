<<<<<<< Updated upstream
# iTrainer

This is iTrainer a website to find your fitness buddy

## To run iTrainer on your local machine you will require the following software:-

* Ruby 2.0.0p451
* Rails 4.1.0
* Postgres 9.3
* imagemagick 6.8.8-9

## Installing the app requires the following steps

* In the command line type in:- `git clone https://github.com/shabankarumba/iTrainer`

* Run `bundle` to install the gems required

* Start the postgres database

* `rake db:setup` to set the database up and add the data in the seeds file

* Edit the file named secrets.yml.example in the repository and add your secrect_key_base, email_username and email_password into the file for the development, test and production environments in the.

To generate a secret key base run `rake secret `

* `rails server` to start the server
=======
== README

This is iTrainer a website to find your fitness buddy

To run iTrainer on your local machine you will require the following software:-

Ruby 2.0.0p451
Rails 4.1.0
Postgres 9.3

Installing the app requires you to do the following steps

`git clone https://github.com/shabankarumba/iTrainer`

run `bundle` to install the gems required

start the postgres database

`rake db:setup`

add your email and password into the config.yml file for the development, test and production environments in the following format:-

development:
  email_username: "example@gmail.com"
  email_password: "hello123"

`rails s` to start the server
>>>>>>> Stashed changes
