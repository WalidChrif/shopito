class Customer::CartController < ApplicationController
    def show
      # session[:cart] = []
      @cart = session[:cart] ||= []
      @order_items = @cart.map do |hash|
        puts "hash[:item_id] #{hash['item_id']}, hash[:quantity] #{hash['quantity']}"
        item = get_order_item(hash['item_id'], hash['quantity'])
      end
      @total_amount = @cart.sum { |hash| get_price(hash['item_id']) * hash['quantity'] }
    end
  
    def add_to_cart
      @cart = session[:cart] ||= []

      item_hash = @cart.find { |hash| hash['item_id'] == params[:id] }

      if item_hash.present?
        item_hash['quantity'] += 1
        flash[:notice] = "#{get_title(item_hash['item_id'])} quantity has been updated to #{item_hash['quantity']}."
      else
        @cart << { item_id: params[:id], quantity: 1 }
        flash[:notice] = "#{get_title(params[:id])} has been added to your cart."
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
    def get_title id
      item_title = Product.find(id).title
    end

  end
