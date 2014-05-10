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

  before_validation :geocode
  geocoded_by :address
  
  scope :by_gender,   lambda { |gender| where(gender: gender) }
  scope :except_user, lambda { |user| where.not(id: user) }
  scope :experience_level, lambda { |experience| where(experience: experience) }
  
  def self.by_age(ages)
    ages = convert_age_params_into_an_array(ages)
    where("age IN (?)", ages)
  end

  def self.filtered_by(params)
    scope =  self.all
    scope = scope.except_user(params[:user_id])  
    scope = scope.by_age(params[:age]) if params[:age]
    scope = scope.by_gender(params[:gender]) if params[:gender]
    scope = scope.near(users_address(params[:user_id]))
    scope = scope.experience_level(params[:experience]) if params[:experience]
    scope
  end

  private

  def self.users_address(id)
    find(id).address
  end

  def self.convert_age_params_into_an_array(age_range)
    ages = age_range.split('..').map(&:to_i)
    if ages.count > 1
      ages = (ages.first..ages.last)
    end
    ages.to_a
  end
end
