class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name,:gender,:age,:screen_name, :address, presence: true
  validates :exercise_type, :experience, :prefered_time, presence: true
  validates :first_name, :last_name , format: {with: /\A[A-Za-z]+\z/}
  validates :about_me, presence: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentPresenceValidator, :attributes => :avatar

  has_one :workout_preference

  accepts_nested_attributes_for :workout_preference

  before_validation :geocode
  geocoded_by :address
  
  scope :gender, lambda { |gender| where(gender: gender) if gender.present? }

  def self.except_user(user)
    where.not(id: user)
  end

end
