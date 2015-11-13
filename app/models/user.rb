class User < ActiveRecord::Base

  has_secure_password


  USERMARKER = [
    "/lib/images/marker_andrew.png",
    "/lib/images/marker_john.png",
    "/lib/images/marker_tendai.png",
    "/lib/images/marker_dhl.png"
  ]

  # added allow_nil to others than password as they might be helpful when updating others???

  validates :username, presence: true, uniqueness: true, allow_nil: true
  validates :password_digest, presence: true
  validates :password, length: {
    minimum: 8, allow_nil: true
  }
  validates :email, presence: true, uniqueness: true, allow_nil:true
  validates :full_name, presence: true, allow_nil: true


  has_many :trips, dependent: :destroy
  has_many :comments, through: :trips
end
