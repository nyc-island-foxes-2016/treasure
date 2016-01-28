class User < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3, maximum: 30}
  validates :email, presence: true, uniqueness: true
  has_secure_password

  # Paperclip code
  attr_accessible :avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :items
  has_many :swipes, through: :items #TODO: verify
  has_many :matches, through: :swipes  #TODO: verify
  has_many :messages
end
