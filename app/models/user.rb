class User < ApplicationRecord
  has_many :orders
  has_many :comment, dependent: :destroy
  has_many :rate, dependent: :destroy
  has_many :suggest, dependent: :destroy
  has_many :cart, dependent: :destroy

  before_save :downcase_email

  attr_accessor :remember_token

  has_secure_password
  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: {maximum: Settings.maximum_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :address, presence: true, length: {maximum: Settings.maximum_address}
  validates :phone, presence: true, numericality: {only_integer: true},
    length: {in: Settings.minimum_phone..Settings.maximum_phone}
  validates :password, presence: true, length: {minimum: Settings.minimum_password}

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute :remember_digest, nil
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
