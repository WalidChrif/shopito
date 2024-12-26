class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
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
  enum :role, { customer: 0, seller: 1, admin: 2 }  # Note the :role symbol before the hash
  validates :role, inclusion: { in: User.roles.keys }


  after_initialize do
    self.role ||= :customer
  end

  def admin?
    role == 'admin'
  end

  def seller?
    role == 'seller'
  end

  def customer?
    role == 'customer'
  end

  
  def full_name
    "#{first_name} #{last_name}"
  end


end
