class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_one_attached :image

  def owned_by?(user)
    user && user.id == user_id
  end

  def tag_names
    tags.pluck(:name).join(" ")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title body created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user tags]
  end
end
