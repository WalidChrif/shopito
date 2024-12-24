class Customer::CheckoutController < ApplicationController
    def show
        @product = Product.find(params[:id])
    end

    def place_order
        @product = Product.find(params[:product_id])

        if @product.update(sales_count: @product.sales_count + 1) && @product.update(stock: @product.stock - 1)
            redirect_to customer_receipt_path(@product), notice: 'Order placed successfully.'
        else 
            redirect_to customer_checkout_path(@product), alert: 'There was a problem with your order.'
        end
    end

    def receipt
        @product = Product.find(params[:id])
    end

end