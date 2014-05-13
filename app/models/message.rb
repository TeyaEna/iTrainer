class Message < ActiveRecord::Base
  attr_accessor :screen_name
  belongs_to :sender, class_name: 'User', foreign_key: "sender_id"
  belongs_to :receiver, class_name: 'User', foreign_key: "receiver_id"   
  validates :body, :subject, presence: true

  before_save :set_receiver_id

  def set_receiver_id
    self.receiver_id = find_user_screen_name.id
  end

  private

  def find_user_screen_name
    User.find_by_screen_name(@screen_name)
  end
end