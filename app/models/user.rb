class User < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3, maximum: 30}
  validates :email, presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
            uniqueness: { case_sensitive: false }
  has_secure_password

  # Paperclip code
  # attr_accessible :avatar
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :items
  has_many :given_swipes, through: :items
  has_many :received_swipes, through: :items
  has_many :messages

  def self.create_or_get_from_oauth(hash)
    existing = User.find_by(provider: hash[:provider], uid: hash[:uid])
    if existing
      return existing
    else
      u = User.new(provider: hash[:provider], uid: hash[:uid])
      u.password = SecureRandom.hex(32)
      u.email = hash[:info][:email]
      u.username = hash[:info][:name]
      u.save
      return u
    end
  end
end
