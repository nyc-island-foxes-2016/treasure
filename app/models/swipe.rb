class Swipe < ActiveRecord::Base
  validates :owned_item_id, presence: true
  validates :judged_item_id, presence: true
  validates :direction, presence: true

  belongs_to :owned_item, foreign_key: :owned_item_id, class_name: "Item"
  belongs_to :judged_item, foreign_key: :judged_item_id, class_name: "Item"
  has_many :proposed_swipe_matches, foreign_key: :swipe1_id, class_name: "Match"
  has_many :accepted_swipe_matches, foreign_key: :swipe2_id, class_name: "Match"

  after_save :make_match

  def make_match
    return unless direction == "R"
    first_swipe = Swipe.find_by(judged_item: self.owned_item, owned_item: self.judged_item, direction: "R")
    Match.create!(first_swipe: first_swipe, second_swipe: self) if first_swipe
  end

end
