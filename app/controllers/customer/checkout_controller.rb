class Customer::CheckoutController < ApplicationController
    before_action :set_cart, only: [:place_order, :receipt]
    before_action :set_total_price, only: [:place_order, :receipt] 
    # after_action :set_total_price

    def show

    end

    def place_order
        if Customer.find_by(email: params[:email]).present?
            customer = Customer.find_by(email: params[:email])
        else
            customer = Customer.new(first_name: params[:first_name], last_name: params[:last_name], address: params[:address], email: params[:email])
        end
        customer.save
        order = Order.new(customer_id: customer.id, total_items: @cart.sum { |item| item['quantity'] }, total_price: @total_price, shipping_address: params[:address])
        @cart.each do |item|
            item_price = Product.find(item['item_id']).price
            item_title = Product.find(item['item_id']).title
            order_item = OrderItem.new( quantity: item['quantity'], price: item_price, title: item_title, order_id: order.id)
            Product.find(item['item_id']).update(stock: Product.find(item['item_id']).stock - item['quantity'])
            order_item.save
            order.order_items << order_item
        end
        if order.save  
            redirect_to customer_receipt_path(order), notice: "Order placed successfully"
        else
            redirect_to customer_checkout_path, notice: "Order not placed"
        end
    end

    def receipt
        @order = Order.find(params[:id])
        @order_items = @order.order_items
        session[:cart] = []
    end

    def print_receipt
        @order = Order.find(params[:id])
        @order_items = @order.order_items
        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "receipt", template: "customer/checkout/receipt.html.erb"
            end
        end
    end

    private
    
    def set_cart
        @cart = session[:cart].dup if !session[:cart].empty?

    end

    def set_total_price 
        @total_price = @cart.sum { |item| Product.find(item['item_id']).price * item['quantity'] } if !@cart.nil?
    end
end