# frozen_string_literal: true

json.extract! order, :id, :store_order_id, :subtotal, :shipping_total, :status, :payment, :seller_id, :created_at,
              :updated_at
json.url order_url(order, format: :json)
