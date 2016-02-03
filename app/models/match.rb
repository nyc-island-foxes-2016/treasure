class Match < ActiveRecord::Base
  validates :given_swipe, :received_swipe, presence: true

  belongs_to :given_swipe, class_name: 'Swipe', inverse_of: :given_swipe_matches
  belongs_to :received_swipe, class_name: 'Swipe', inverse_of: :received_swipe_matches

  has_many :messages

  delegate :my_item, to: :given_swipe
  delegate :other_item, to: :given_swipe

  alias item_1 my_item
  alias item_2 other_item

  def other(item)
    item == item_1 ? item_2 : item_1
  end

  def make_swap_if_mutual_swap(item)
    other_item = self.other(item)
    if other_item.swapped
      self.update_attributes(swapped_at: DateTime.now)
    end
  end

  def belongs_to_item?(item)
    item == my_item || item == other_item
  end

end
