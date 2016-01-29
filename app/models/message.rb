class Message < ActiveRecord::Base
  validates :content, presence: true, length: {minimum: 1, maximum: 400}
  validates :match_id, :user_id, presence: true

  belongs_to :match
  belongs_to :user
end
