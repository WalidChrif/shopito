class Product < ApplicationRecord

    validates :title, presence: true
    validates :price, presence: true
    validates :stock, presence: true
    validates :sales_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :discount, presence: true
    validates :description, presence: true
    validates :image_url, presence: true


    scope :top_sellers, -> { order(sales_count: :desc).limit(3) }
    scope :new_arrivals, -> { order(created_at: :desc).limit(3) }
    scope :best_deals, -> { order(discount: :desc).limit(3) }



end
