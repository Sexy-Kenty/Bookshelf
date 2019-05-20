class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password

    # 本棚登録機能（読みたい、読んだ）
    has_many :ownerships
    has_many :items, through: :ownerships
    
    has_many :haves, class_name: "Have"
    has_many :have_items, through: :haves, source: :item
    
    has_many :wants
    has_many :want_items, through: :wants, source: :item

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
    
    def want(item)
      self.wants.find_or_create_by(item_id: item.id)
    end
    
    def unwant(item)
      want = self.wants.find_by(item_id: item.id)
      want.destroy if want
    end
    
    def want?(item)
      self.want_items.include?(item)
    end

    #フォロー機能中間テーブル
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user


    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end

    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end

    def following?(other_user)
      self.followings.include?(other_user)
    end

    #口コミ投稿
    has_many :posts, dependent: :destroy

end
