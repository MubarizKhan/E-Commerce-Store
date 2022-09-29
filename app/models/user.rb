class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy

  # has_many :comments, dependent: :destroy
  has_one_attached :cover_picture



  # attr_accessor :full_name
  # before_validation :set_names

   private

  #  def set_names
  #     names = full_name.split
  #     self.first_name = names.first
  #     self.last_name = names.last
  #  end
end
