class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[ submit]
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def submit
    @order = nil
    #Check which type of order it is
    if order_params[:payment_gateway] == "stripe"
      prepare_new_order
      Orders::Stripe.execute(order: @order, user: current_user)
    elsif order_params[:payment_gateway] == "paypal"
      #PAYPAL WILL BE HANDLED HERE
    end
    ensure
      if @order&.save
        if @order.paid?
          # Success is rendered when order is paid and saved
          return render html: SUCCESS_MESSAGE
        elsif @order.failed? && !@order.error_message.blank?
          # Render error only if order failed and there is an error_message
          return render html: @order.error_message
        end
      end
      render html: FAILURE_MESSAGE
    end
  

  private
  # Initialize a new order and and set its user, product and price.
  def prepare_new_order
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @product = Product.find(@order.product_id)
    @order.price_cents = @product.price_cents
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      if action_name == "submit"
       params.require(:orders).permit(:product_id, :user_id, :status, :boolean, :token, :price_cents, :payment_gateway, :customer_id)
      else
        params.require(:order).permit(:product_id, :user_id, :status, :boolean, :token, :price_cents, :payment_gateway, :customer_id)
      end
    end
end
