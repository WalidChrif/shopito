class Customer::CartController < ApplicationController
    def show
      @cart = session[:cart] ||= []
      @order_items = @cart.map { |order_item_id| OrderItem.find_by(id: order_item_id) }.compact
  
      @order_items.each_with_index do |order_item, index|
        puts "Index: #{index}, OrderItem ID: #{order_item.id}, Product: #{order_item.product.title}"
      end
  
      @total_items = @order_items.sum(&:quantity)
      @total_amount = @order_items.sum { |order_item| order_item.product.price * order_item.quantity }
    end
  
    def add_to_cart
      @cart = session[:cart] ||= []
  
      product = Product.find_by(id: params[:id])
      if product.nil?
        flash[:error] = "Product not found."
        redirect_back(fallback_location: cart_path)
        return
      end
  
      # Check if the product is already in the cart
      order_item = @cart.map { |order_item_id| OrderItem.find_by(id: order_item_id) }.find { |item| item&.product_id == product.id }
  
      if order_item.present?
        # Update quantity if the item already exists
        order_item.increment!(:quantity)
        flash[:success] = "#{order_item.product.title} quantity has been updated to #{order_item.quantity}."
      else
        # Create a new OrderItem and add it to the cart
        order_item = OrderItem.create(
          product_id: product.id,
          quantity: 1,
          price: product.price,
          title: product.title
        )
        @cart << order_item.id
        flash[:success] = "#{product.title} has been added to your cart."
      end
  
      session[:cart] = @cart
      redirect_back(fallback_location: cart_path)
    end
  
    def remove_from_cart
      @cart = session[:cart] ||= []
  
      order_item_id = params[:order_item_id].to_i
      order_item = OrderItem.find_by(id: order_item_id)
  
      if order_item
        @cart.delete(order_item_id)
        order_item.destroy
        flash[:success] = "#{order_item.product.title} has been removed from your cart."
      else
        flash[:error] = "Order item not found."
      end
  
      session[:cart] = @cart
      redirect_to cart_path
    end

    def product_to_order_item(product)
      OrderItem.new(
        product_id: product.id,
        quantity: 1,
        price: product.price,
        title: product.title
      )
    end
  end
  