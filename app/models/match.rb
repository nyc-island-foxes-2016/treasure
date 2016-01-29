class Match < ActiveRecord::Base
  validates :given_swipe, :received_swipe, presence: true

  belongs_to :given_swipe, foreign_key: :given_swipe_id, class_name: "Swipe"
  belongs_to :received_swipe, foreign_key: :received_swipe_id, class_name: "Swipe"
  has_many :messages
end
