class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :ownerships
    has_many :items, through: :ownerships
    
    has_many :haves, class_name: "Have"
    has_many :have_items, through: :haves, source: :item
    
    
    def have(item)
    self.haves.find_or_create_by(item_id: item.id)
    end
  
    def unhave(item)
    have = self.haves.find_by(item_id: item.id)
    have.destroy if have
    end
  
    def have?(item)
    self.have_items.include?(item)
    end

end
