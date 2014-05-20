class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: "sender_id"
  belongs_to :receiver, class_name: 'User', foreign_key: "receiver_id"   
  validates :body, :subject, presence: true

  scope :all_received_messages, lambda { |user| where(:receiver_id => user).order(:created_at => :desc) }
  scope :received_messages, lambda {|receiver, sender| where(receiver_id: receiver, sender_id: sender).order(created_at: :desc) }
  scope :sent_messages, lambda {|sender, receiver| where(sender_id: sender, receiver_id: receiver).order(created_at: :desc) }

  after_save :new_message

  def new_message
    MessageMailer.new_message(self).deliver
  end
end