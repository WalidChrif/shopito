class Seller::ProductsController < ApplicationController

    # @current_seller = {name: "John Doe", email: "4eC3p@example.com", products: ["Product 1", "Product 2", "Product 3"], orders: ["Order 1", "Order 2", "Order 3"]};

    def dashboard
        @current_seller = {name: "John Doe", email: "4eC3p@example.com", products: ["Product 1", "Product 2", "Product 3"], orders: ["Order 1", "Order 2", "Order 3"]};
    end

    def index
        @products = Product.all
        redirect_to dashboard_path
    end
    def show
        @product = Product.find(params[:id])
    end
end