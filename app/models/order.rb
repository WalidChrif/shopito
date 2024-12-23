class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :orderItems
end
