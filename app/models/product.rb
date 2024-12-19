class Product < ApplicationRecord

    def initialize(attributes = {})
      super
      self.sales_count ||= 0
    end

    validates :title, presence: true
    validates :price, presence: true
    validates :stock, presence: true


    scope :top_sellers, -> { order(sales_count: :desc).limit(3) }
    scope :new_arrivals, -> { order(created_at: :desc).limit(3) }
    scope :best_deals, -> { order(discount: :desc).limit(3) }


end
