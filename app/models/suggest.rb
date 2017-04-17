class Suggest < ApplicationRecord
  self.inheritance_column = nil

  enum status: {received: 0, processing: 1, processed: 2}

  belongs_to :user

  validates :info, presence: true, length: {maximum: Settings.maximum_suggest}

  scope :all_suggest, -> {order("created_at desc")}
<<<<<<< HEAD
  scope :suggest_create_today, -> {where("DATE(created_at) = ?", Date.today)}
=======
>>>>>>> multi

  delegate :name, to: :user
  delegate :email, to: :user
end
