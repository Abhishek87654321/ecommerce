json.extract! order, :id, :product_id, :user_id, :status, :boolean, :token, :price_cents, :payment_gateway, :customer_id, :created_at, :updated_at
json.url order_url(order, format: :json)
