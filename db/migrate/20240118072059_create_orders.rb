class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :status, default: 0
      t.string :token
      t.integer :payment_gateway
      t.string :customer_id
      t.string :charge_id
      t.string :error_message
      t.timestamps
    end
    add_money :orders, :price, currency: { present: false }
  end
end
