# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :seller
  has_many :taxes
  has_many :order_items
  has_one :shipping_address
end
