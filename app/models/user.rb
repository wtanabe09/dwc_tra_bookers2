class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
         
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :follows, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  
  
  
  validates :name, length: {in: 2..20}, uniqueness: true, presence: true
  validates :introduction, length: {maximum: 50}
  
  def followed_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end
  
  def self.search(search)
    if search.present?
      if @method == "perfect"
        User.where(['name LIKE ?', "#{search}"])
      elsif @method == "forward"
        User.where(['name LIKE ?', "#{search}%"])
      elsif @method == "forward"
        User.where(['name LIKE ?', "%#{search}"])
      else
        User.where(['name LIKE ?', "%#{search}%"])
      end
    else
      User.all
    end
  end
  
end
