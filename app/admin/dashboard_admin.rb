Trestle.admin(:dashboard) do
    menu do
      item :dashboard, icon: "fa fa-home", priority: :first
    end
  
    controller do
      def index
        @orders = Order.all
        @total_earnings = Order.sum(:total_price)
        # @total_revenue = Order.sum(:total_price)
        @total_revenue = Product.sum('price * sales_count')
        @total_orders = Order.count
        @total_products = Product.count
        @total_users = User.count
        @total_sales = Product.sum(:sales_count)
        @customers = Customer.all
        @products = Product.all
        @admins = User.where(role: :admin)
        # Add more statistics as needed
      end
    end

  
    breadcrumb do
      nil
    end
  end