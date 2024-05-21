class User < ApplicationRecord
  include Accounts
  include Agreement

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_person_name

  has_one_attached :image

  has_many :departments, class_name: "Department", foreign_key: :owner_id, inverse_of: :owner, dependent: :nullify
  has_many :jobs, class_name: "Job", foreign_key: :owner_id, inverse_of: :owner, dependent: :nullify

  validates :name, presence: true
end
