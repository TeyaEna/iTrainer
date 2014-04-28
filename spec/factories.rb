require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name "Foo"
    last_name "Bar"
    age 25
    gender "Male"
    exercise_type "Compound"
    experience "Beginner"
    email "foo@bar.com"
    password "foobar12"
    password_confirmation "foobar12"
    screen_name "foobaz"
    about_me "I am a foo bar"
  end
end

