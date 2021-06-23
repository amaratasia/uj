# frozen_string_literal: true

class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :order
  delegate :name, to: :customer
end
