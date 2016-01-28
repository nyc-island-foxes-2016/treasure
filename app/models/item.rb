class Item < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :description, presence: true, length: {maximum: 1000}
  validates :user_id, presence: true

  belongs_to  :user
  has_many    :given_swipes, foreign_key: :owned_item_id, class_name: "Swipe"
  has_many    :received_swipes, foreign_key: :judged_item_id, class_name: "Swipe"
  has_many    :matches, through: :swipes

end
