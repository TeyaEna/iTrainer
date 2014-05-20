# iTrainer

This is iTrainer a website to find your fitness buddy

## To run iTrainer on your local machine you will require the following software:-

* Ruby 2.0.0p451
* Rails 4.1.0
* Postgres 9.3
* imagemagick 6.8.8-9

## Installing the app requires the following steps

1. In the command line type in:- `git clone https://github.com/shabankarumba/iTrainer`

2. Run `bundle` to install the gems required

3. Start the postgres database

4. `rake db:setup` to set the database up and add the data in the seeds file

5. Add your email and password into the secrets.yml file for the development, test and production environments in the following format:-

```ruby
development:
  email_username: "example@gmail.com"
  email_password: "hello123"
```

6. `rails server` to start the server