class Match < ActiveRecord::Base
  validates :swipe1_id, :swipe2_id, presence: true

  belongs_to :first_swipe, foreign_key: :swipe1_id, class_name: "Swipe"
  belongs_to :second_swipe, foreign_key: :swipe2_id, class_name: "Swipe"
  has_many :messages
end
