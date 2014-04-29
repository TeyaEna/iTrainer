require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name "Foo"
    last_name "Bar"
    age 25
    gender "Male"
    email "foo@bar.com"
    password "foobar12"
    password_confirmation "foobar12"
    screen_name "foobaz"
    about_me "I am a foo bar"
    avatar Rails.root.join("spec/fixtures/images/ruby.png").open
  end
  factory :workout_preference do
    exercise_type "Compound"
    experience "Beginner"
    prefered_place "Hyde park"
    prefered_time "Early Morning 6am-8am"
    user
  end
end

