# frozen_string_literal: true

json.extract! product, :id, :shopify_id, :title, :body, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
