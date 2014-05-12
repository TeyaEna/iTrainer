require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name "Foo"
    last_name "Bar"
    age 25
    gender "Male"
    sequence(:email) {|n| "fooz#{n}@bar.com" }
    password "foobar12"
    password_confirmation "foobar12"
    screen_name "foobaz"
    about_me "I am a foo bar"
    avatar Rails.root.join("spec/fixtures/images/ruby.png").open
    address "New York, NY"
    exercise_type "Strength"
    experience "Beginner"
    prefered_place "Hyde park"
    prefered_time "Early Morning 6am-8am"
  end

  factory :message do
    body "Hello"
    subject "Hi"
  end
end

