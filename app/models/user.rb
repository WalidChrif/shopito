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
  #  type       :string

  validates :first_name, :last_name, :email, :password, presence: true
  


end
