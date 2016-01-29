class Swipe < ActiveRecord::Base
  validates :owned_item_id, presence: true
  validates :judged_item_id, presence: true
  validates :direction, presence: true

  belongs_to :owned_item, foreign_key: :owned_item_id, class_name: "Item"
  belongs_to :judged_item, foreign_key: :judged_item_id, class_name: "Item"
  has_many :first_match_swipes, foreign_key: :swipe1_id, class_name: "Match"
  has_many :second_match_swipes, foreign_key: :swipe2_id, class_name: "Match"

end
