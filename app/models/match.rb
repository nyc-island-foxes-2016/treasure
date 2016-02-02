class Match < ActiveRecord::Base
  validates :given_swipe, :received_swipe, presence: true

  belongs_to :given_swipe, class_name: 'Swipe', inverse_of: :given_swipe_matches
  belongs_to :received_swipe, class_name: 'Swipe', inverse_of: :received_swipe_matches

  has_many :messages

  delegate :my_item, to: :given_swipe
  delegate :other_item, to: :given_swipe

  alias item_1 my_item
  alias item_2 other_item

  def self.find_match(item_1, item_2)
    Match.all.detect do |match|
      (match.my_item == item_1 && match.other_item == item_2) || (match.my_item == item_2 && match.other_item == item_1)
    end
  end

  def other(item)
    if item == self.item_1
      return self.item_2
     else
      return self.item_1
    end
  end

  def make_swap_if_mutual_swap(item)
    other_item = self.other(item)
    if other_item.swapped
      self.update_attributes(swapped_at: DateTime.now)
    end
  end

  def item_belongs_to?(item)
    if self.my_item == item || self.other_item == item
      return true
    else
      false
    end
  end

end
