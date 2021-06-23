# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :school, optional: true
  has_many :images
  has_many :variants
  has_many :product_attributes
end
