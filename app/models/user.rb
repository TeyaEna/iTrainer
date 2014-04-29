class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name,:gender,:age,:screen_name, presence: true
  validates :first_name, :last_name , format: {with: /\A[A-Za-z]+\z/}
  validates :about_me, :experience, presence: true, :if => lambda {|obj| obj.step?("2nd step") }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, :if => lambda {|obj|obj.step?("2nd step") }
  validates_with AttachmentPresenceValidator, :attributes => :avatar, :if => lambda {|obj|obj.step?("2nd step") }

  def step?(current_step)
    self.step == current_step
  end
end
