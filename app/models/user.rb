# frozen_string_literal: true

class User < ApplicationRecord
  rolify before_add: :before_add_method
  # after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :display_picture
  has_one :cart, dependent: :destroy

  attr_accessor :first_name, :last_name

  before_create :set_names


  def before_add_method(_role)
    # do something before it gets added
    print 'SOME THING IS HAPPENING'
  end

  # def assign_default_role
  #   add_role(:newuser) if roles.blank?
  # end

  private

  def set_names
    self.full_name = first_name + last_name
  end
end
