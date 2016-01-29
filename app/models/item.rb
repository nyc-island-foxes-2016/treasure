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

  # def self.available
  #   #query for items that are not the current users item
  #   self.where.not(user_id: current_user.id)

  #   #query for items that the user has already swiped on
  #   self.includes(:given_swipes).where.not(my_item_id: self.id)
  #     #the other_item_id/s in self.given_swipes where my_item_id= current_user.item.id
  # end

#Nicola (1) has item (1) swipes R (1) on item (2) owned by Darius (2) == Match (1)



  def self.available(user)
    where_clause = " user_id != ? and id not in " +
     " (       select s.other_item_id from swipes s join items i on i.id = s.my_item_id " +
     "  where i.user_id = ? ) "
   where(where_clause, user.id, user.id)

  end

end


# => #<Swipe:0x007fa0c88287a8
#  id: 1,
#  my_item_id: 1, #chanel
#  other_item_id: 2, #nexus
#  direction: "R",

# => #<Swipe:0x007fa0c4782e88
#  id: 2,
#  my_item_id: 2, #nexus
#  other_item_id: 1, #chanel
#  direction: "R",
