class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name,:gender,:age,:screen_name, :address, presence: true
  validates :exercise_type, :experience, :prefered_time, presence: true
  validates :first_name, :last_name , format: {with: /\A[A-Za-z]+\z/}
  validates :about_me, presence: true, length: { minimum: 100 }

  has_attached_file :avatar, :styles => {:large => "300x300#", :medium => "250x250#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentPresenceValidator, :attributes => :avatar

  before_validation :geocode
  geocoded_by :address

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"
  
  scope :by_gender,   lambda { |gender| where(gender: gender) }
  scope :except_user, lambda { |user| where.not(id: user) }
  scope :experience_level, lambda { |experience| where(experience: experience) }
  scope :by_exercise_type, lambda { |exercise| where(exercise_type: exercise) }
  scope :by_age, lambda { |ages| where(age: ages) }

  def self.filtered_by(params)
    scope =  self.all
    scope = scope.except_user(params[:user_id])  
    scope = scope.by_age(params[:age]) if params[:age].present?
    scope = scope.by_gender(params[:gender]) if params[:gender].present?
    scope = scope.near(users_address(params[:user_id]))
    scope = scope.experience_level(params[:experience]) if params[:experience].present?
    scope = scope.by_exercise_type(params[:exercise]) if params[:exercise].present?
    scope
  end

  private

  def self.users_address(id)
    find(id).address
  end
end
