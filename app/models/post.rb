class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def owned_by?(user)
    user && user.id == user_id
  end
end
