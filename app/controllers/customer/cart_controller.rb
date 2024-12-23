class Customer::CartController < ApplicationController

    def show
        session[:cart]=[]
        @cart = session[:cart] ||= []
        @cart.each_with_index do |orderItem_id, index|
            puts " index is #{index}"
            puts "orderItem_id is #{orderItem_id}"
            orderItem = OrderItem.find(orderItem_id)
            puts "#{index + 1}. Product : #{orderItem.product.title}"
        end
        @total_items = @cart ? @cart.count : 0
        @total_amount = @cart ? @cart.sum { |orderItem_id| OrderItem.find(orderItem_id).product.price } : 0
    end

    def add_to_cart
        @cart = session[:cart] ||= []
        orderItem = @cart.find_by(product_id: params[:id])
        if orderItem.present?
            orderItem.quantity += 1
            @cart << orderItem
            flash[:success] = "#{orderItem.product.title} quantity has been updated to #{orderItem.quantity}."
            redirect_back(fallback_location: customer_cart_path)
            return
        else
            ordedrItem = OrderItem.create(product_id: @product.id, quantity: 1)
            @cart << ordedrItem
            flash[:success] = "#{@product.title} has been added to your cart."
            redirect_back(fallback_location: customer_cart_path)
        end
        puts "cart before: #{@cart}"

    end 

    def remove_from_cart
        @product = Product.find(params[:product_id])
        @cart = session[:cart] ||= []
        @cart.delete(@product.id)
        session[:cart] = @cart
        render :show
    end


end