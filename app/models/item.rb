class Item < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :url, presence: true, length: { maximum: 255 }
    validates :isbn, presence: true, length: { maximum: 13 }
    validates :image_url, presence: true, length: { maximum: 255 }

    has_many :ownerships
    has_many :users, through: :ownerships
    
    has_many :haves, class_name: "Have"
    has_many :have_users, through: :haves, source: :user
end
