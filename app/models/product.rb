# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  price       :decimal(, )
#  stock       :integer
#  image_url   :string
#  sales_count :integer          default(0)
#  discount    :decimal(, )      default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#
class Product < ApplicationRecord

    after_initialize :set_sales_count
    
    private
    def set_sales_count
        self.sales_count = 0 if self.sales_count.nil?
    end

    has_many :order_items
    has_many :orders, through: :order_items

    belongs_to :user
    
    validates :title, presence: true
    validates :price, presence: true
    validates :stock, presence: true


    scope :top_sellers, -> { order(sales_count: :desc).limit(3) }
    scope :new_arrivals, -> { order(created_at: :desc).limit(3) }
    scope :best_deals, -> { order(discount: :desc).limit(3) }


end
