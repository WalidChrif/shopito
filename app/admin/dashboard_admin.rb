Trestle.admin(:dashboard) do
    menu do
      item :dashboard, icon: "fa fa-home", priority: :first
    end
  
    controller do
      def index
        if current_user.admin?
            @total_sales = Product.sum(:sales_count)
            @total_earnings = Product.sum('sales_count * price')
            @total_orders = Order.count
            @recent_orders = Order.order(created_at: :desc).limit(5)
            @total_products = Product.count
            @products = Product.all
            @latest_products = Product.order(created_at: :desc).limit(5)
            @best_sellers = Product.order(sales_count: :desc).limit(5)
            @total_users = User.count
            @customers = Customer.all
            @recent_customers = Customer.order(created_at: :desc).limit(5)
        elsif current_user.seller?
            @total_sales = Product.where(user_id: current_user.id).sum(:sales_count)
            @total_earnings = Product.where(user_id: current_user.id).sum('sales_count * price')
            @total_orders = Order.joins(:order_items).where(order_items: { id: Product.where(user_id: current_user.id).select(:id) }).count
            @recent_orders = Order.joins(:order_items).where(order_items: { id: Product.where(user_id: current_user.id).select(:id) }).limit(5)
            @products = Product.where(user_id: current_user.id)
            @total_products = Product.where(user_id: current_user.id).count
            @latest_products = Product.where(user_id: current_user.id).order(created_at: :desc).limit(5)
            @best_sellers = Product.where(user_id: current_user.id).order(sales_count: :desc).limit(5)
        end
      end
    end


    before_action do
        unless current_user.seller? || current_user.admin?
          flash[:error] = "You are not authorized to access this page."
          redirect_to "/"
        end
    end
  
    breadcrumb do
      nil
    end
  end