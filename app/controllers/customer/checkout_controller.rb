class Customer::CheckoutController < ApplicationController
    before_action :set_cart, only: [:place_order, :receipt]
    before_action :set_total_price, only: [:place_order, :receipt] 
    # after_action :set_total_price

    def show

    end

    def place_order
        ActiveRecord::Base.transaction do
          begin
            # Find or create customer
            customer = Customer.find_or_initialize_by(email: params[:email]) do |c|
              c.first_name = params[:first_name]
              c.last_name = params[:last_name]
              c.address = params[:address]
            end
            
            unless customer.save
              flash[:error] = "Could not save customer information: #{customer.errors.full_messages.join(', ')}"
              raise ActiveRecord::Rollback
            end
      
            # Create order
            order = Order.new(
              customer_id: customer.id,
              total_items: @cart.sum { |item| item['quantity'].to_i },
              total_price: @total_price,
              shipping_address: params[:address]
            )
      
            # Pre-fetch all products to avoid multiple queries
            product_ids = @cart.map { |item| item['item_id'] }
            products = Product.where(id: product_ids).index_by(&:id)
      
            # Validate stock before processing
            @cart.each do |item|
              product = products[item['item_id'].to_i]
              if product.nil?
                flash[:error] = "Product not found"
                raise ActiveRecord::Rollback
              end
              
              if product.stock < item['quantity'].to_i
                flash[:error] = "Not enough stock for #{product.title}"
                raise ActiveRecord::Rollback
              end
            end
      
            # Process order items and update stock
            @cart.each do |item|
              product = products[item['item_id'].to_i]
              quantity = item['quantity'].to_i
              
              order_item = order.order_items.build(
                quantity: quantity,
                price: product.price,
                title: product.title,
                product_id: product.id
              )
      
              # Update product stock
              product.update!(stock: product.stock - quantity)
            end
      
            if order.save
              # Clear cart after successful order
              session[:cart] = []
              redirect_to customer_receipt_path(order), notice: "Order placed successfully"
            else
              flash[:error] = "Could not create order: #{order.errors.full_messages.join(', ')}"
              raise ActiveRecord::Rollback
            end
      
          rescue StandardError => e
            flash[:error] = "An error occurred while processing your order: #{e.message}"
            raise ActiveRecord::Rollback
          end
        end
      
        # If we get here, something went wrong
        redirect_to customer_cart_checkout_path unless performed?
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