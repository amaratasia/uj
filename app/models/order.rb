# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :seller
  has_many :taxes
  has_many :order_items
  has_many :products, through: :order_items
  has_one :shipping_address
  delegate :name, to: :shipping_address

  after_create do
    SmsNotification.new({name: shipping_address.name, order_number: store_order_id, order_total: total}, shipping_address.phone).call
  end
end
