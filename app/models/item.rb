class Item < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :description, presence: true, length: {maximum: 1000}
  validates :user_id, presence: true

  belongs_to  :user
  has_many    :given_swipes, foreign_key: :my_item_id, class_name: "Swipe"
  has_many    :received_swipes, foreign_key: :other_item_id, class_name: "Swipe"

  #Necessary only for other associations
  has_many    :given_swipe_matches, through: :given_swipes
  has_many    :received_swipe_matches, through: :received_swipes

  def all_matches
     ids = given_swipe_matches.pluck(:id) + received_swipe_matches.pluck(:id)
     Match.where(id: ids)
  end

  def self.available(user)
    where_clause = " user_id != ? and id not in " +
     " (       select s.other_item_id from swipes s join items i on i.id = s.my_item_id " +
     "  where i.user_id = ? ) "
   where(where_clause, user.id, user.id)

  end

end
