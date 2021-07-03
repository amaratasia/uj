# frozen_string_literal: true

class School < ApplicationRecord
    has_many :products
    has_many :orders, -> { distinct }, through: :products#
end
