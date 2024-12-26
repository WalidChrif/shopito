Trestle.admin(:dashboard) do
    menu do
      item :dashboard, icon: "fa fa-home", priority: :first
    end
  
    controller do
      def index
        @recent_orders = Order.order(created_at: :desc).limit(5)
        @total_earnings = Order.sum(:total_price)
        # @total_revenue = Order.sum(:total_price)
        @total_revenue = Product.sum('price * sales_count')
        @total_orders = Order.count
        @total_products = Product.count
        @total_users = User.count
        @total_sales = Product.sum(:sales_count)
        @customers = Customer.all
        @recent_customers = Customer.order(created_at: :desc).limit(5)
        @products = Product.all
        @best_sellers = Product.order(sales_count: :desc).limit(5)
        @latest_products = Product.order(created_at: :desc).limit(5)
        @admins = User.where(role: :admin)
        # Add more statistics as needed
      end
    end

  
    breadcrumb do
      nil
    end
  end