class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name,:gender,:age,:screen_name, :address, presence: true
  validates :exercise_type, :experience, :prefered_time, presence: true
  validates :first_name, :last_name , format: {with: /\A[A-Za-z]+\z/}
  validates :about_me, presence: true

  has_attached_file :avatar, :styles => { :medium => "250x250#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentPresenceValidator, :attributes => :avatar

  has_one :workout_preference

  accepts_nested_attributes_for :workout_preference

  before_validation :geocode
  geocoded_by :address
  
  scope :by_gender,   lambda { |gender| where(gender: gender) }
  scope :by_age,      lambda { |age| where("age IN (?)", age) }
  scope :except_user, lambda { |user| where.not(id: user) }
  
  def self.users_address(id)
    self.find(id).address
  end

  def self.filtered_by(params)
    scope =  self.all
    scope.except_user(params[:user_id])  
    scope.by_age(params[:age]) if params[:age]
    scope.by_gender( params[:gender]) if params[:gender]
    scope.near(users_address(params[:user_id]))
    scope
  end

end
