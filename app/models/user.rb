# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  
  belongs_to :school, optional: true
  has_many :products, through: :school
  has_many :orders, through: :school
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  include RoleModel
        #  roles :admin, :manager, :author
  def products
    if has_role? :admin
      Product.all
    else
      super
    end
  end


  def orders
    if has_role? :admin
      Order.all
    else
      super
    end
  end
end
