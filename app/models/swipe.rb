class Swipe < ActiveRecord::Base
  validates :my_item, presence: true
  validates :other_item, presence: true
  validates :direction, presence: true

  belongs_to :my_item, foreign_key: :my_item_id, class_name: "Item"
  belongs_to :other_item, foreign_key: :other_item_id, class_name: "Item"

  #Necessary only for other associations
  has_many :given_swipe_matches, foreign_key: :given_swipe_id, class_name: "Match"
  has_many :received_swipe_matches, foreign_key: :given_swipe_id, class_name: "Match"
  # after_save :make_match

  def make_match
    return false unless direction == "R"
    #Find if another 'swipe right' exists with same two items
    first_swipe = Swipe.find_by(other_item: self.my_item, my_item: self.other_item, direction: "R")
    return Match.create!(given_swipe: first_swipe, received_swipe: self) if first_swipe
    return false
  end

end
