class Order < ApplicationRecord
  
  belongs_to :customer, optional: true
  has_many :orderItems, dependent: :destroy

end
