class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name,:gender,:age,:screen_name, presence: true
  validates :first_name, :last_name , format: {with: /\A[A-Za-z]+\z/}
  validates :about_me, :experience, presence: true, on: :update
end
