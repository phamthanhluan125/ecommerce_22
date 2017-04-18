class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :rate_of_product, ->{sum("point")}
  scope :all_rates, ->{order("created_at desc")}
  scope :this_day, ->(date){where "DATE(created_at) = ?" , date}

  delegate :id, to: :user, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :id, to: :product, prefix: true
  delegate :name, to: :product
end
