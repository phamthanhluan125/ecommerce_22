class Product < ApplicationRecord
  belongs_to :categorie

  has_many :order_details
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :carts, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :info, presence: true
  validates :price, presence: true, length: {maximum: Settings.maximum_price,
    minimum: Settings.minimum_price}
  validates :categorie_id, presence:true
  validate :image_size

  private

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "picture_than_5MB")
    end
  end
end
