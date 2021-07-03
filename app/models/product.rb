# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :school, optional: true
  has_many :images
  has_many :order_items
  has_many :orders, -> { distinct }, through: :order_items
  has_many :variants
  has_many :product_attributes
end
