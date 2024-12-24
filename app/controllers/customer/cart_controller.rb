class Customer::CartController < ApplicationController
    def show
      # session[:cart] = []
      @cart = session[:cart] ||= []
      @order_items = @cart.map do |hash|
        puts "hash[:item_id] #{hash['item_id']}, hash[:quantity] #{hash['quantity']}"
        item = get_order_item(hash['item_id'], hash['quantity'])
        puts "item.title: #{item.title}, item.price: #{item.price}, item.quantity: #{item.quantity}"
        item
      end
      @total_amount = @cart.sum { |hash| get_price(hash['item_id']) * hash['quantity'] }
    end
  
    def add_to_cart
      @cart = session[:cart] ||= []

      item_hash = @cart.find { |hash| hash['item_id'] == params[:id] }
      puts "item_hash: #{item_hash}"

      if item_hash.present?
        puts "order item already in cart"
        item_hash['quantity'] += 1
      else
        puts "order item not in cart"
        @cart << { item_id: params[:id], quantity: 1 }
      end
  
      session[:cart] = @cart
      redirect_back(fallback_location: customer_cart_path)
    end
  
    def remove_from_cart
      @cart = session[:cart] ||= []
  
      order_item_id = params[:order_item_id].to_i
      order_item = @cart.find { |order_item| order_item['item_id'] == order_item_id }
  
      if order_item
        @cart.delete(order_item)
        flash[:success] = "#{order_item['title']} has been removed from your cart."
      else
        flash[:error] = "Order item not found."
      end
  
      session[:cart] = @cart
      redirect_to customer_cart_path
    end

    def product_to_order_item(product, quantity)
      OrderItem.new(
        id: product.id,
        quantity: quantity,
        price: product.price,
        title: product.title
      )
    end

    def get_order_item id, quantity
      order_item = product_to_order_item(Product.find(id), quantity)
    end
    def get_price id
      item_price = Product.find(id).price
    end

  end
  # flash[:notice] = "#{order_item.title} quantity has been updated to #{order_item.quantity}."
  # flash[:notice] = "#{order_item.title} quantity has been added to your cart."
