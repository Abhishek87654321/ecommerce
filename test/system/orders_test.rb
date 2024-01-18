require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Boolean", with: @order.boolean
    fill_in "Customer", with: @order.customer_id
    fill_in "Payment gateway", with: @order.payment_gateway
    fill_in "Price cents", with: @order.price_cents
    fill_in "Product", with: @order.product_id
    fill_in "Status", with: @order.status
    fill_in "Token", with: @order.token
    fill_in "User", with: @order.user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Boolean", with: @order.boolean
    fill_in "Customer", with: @order.customer_id
    fill_in "Payment gateway", with: @order.payment_gateway
    fill_in "Price cents", with: @order.price_cents
    fill_in "Product", with: @order.product_id
    fill_in "Status", with: @order.status
    fill_in "Token", with: @order.token
    fill_in "User", with: @order.user_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
