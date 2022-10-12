class User < ApplicationRecord

  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :display_picture
  has_one :cart, dependent: :destroy



  attr_accessor :first_name
  attr_accessor :last_name
  before_create :set_names


#   def choose_role
#    @user = current_user

#   end




  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

   private

   def set_names
      self.full_name = first_name + last_name
   end
end
