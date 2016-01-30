class Match < ActiveRecord::Base
  validates :given_swipe, :received_swipe, presence: true

  belongs_to :given_swipe, foreign_key: :given_swipe_id, class_name: "Swipe"
  belongs_to :received_swipe, foreign_key: :received_swipe_id, class_name: "Swipe"

  has_many :messages

  delegate :my_item, to: :given_swipe
  delegate :other_item, to: :given_swipe

  alias item_1 my_item
  alias item_2 other_item

  def other(item)
    if item == self.item_1
      return self.item_2
     else
      return self.item_1
    end
  end

end
