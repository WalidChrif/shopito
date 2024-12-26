class User < ApplicationRecord
    
  # == Schema Information
  #
  # Table name: users
  #
  #  id         :integer          not null, primary key
  #  first_name :string
  #  last_name  :string
  #  email      :string
  #  password   :string
  #  created_at :datetime         not null
  #  updated_at :datetime         not null
  #  role       :string

  has_many :products

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  
  validates :role, inclusion: { in: roles }

  enum role: { customer: 0, seller: 1, admin: 2 }

  def full_name
    "#{first_name} #{last_name}"
  end
  def admin?
    role == "admin"
  end
  def customer?
    role == "customer"
  end
  def seller?
    role == "seller"
  end
   

  


end
