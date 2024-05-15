class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates_acceptance_of :accepted, allow_nil: false, on: :create

  has_one_attached :image

  validates :name, presence: true
end
