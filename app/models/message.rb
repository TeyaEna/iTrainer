class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: "sender_id"
  belongs_to :receiver, class_name: 'User', foreign_key: "receiver_id"   
  validates :body, :subject, presence: true

  scope :received_messages, lambda { |user| where(receiver_id: user).order(created_at: :desc).group_by(&:sender_id)}

  scope :received_message, lambda {|receiver, sender| where(receiver_id: receiver, sender_id: sender).order(created_at: :desc) }
  scope :sent_message, lambda {|sender, receiver| where(sender_id: sender, receiver_id: receiver).order(created_at: :desc) }

end