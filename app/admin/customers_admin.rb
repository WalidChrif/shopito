Trestle.resource(:customers) do
  menu do
    if current_user.admin?
      item :customers, icon: "fa fa-star", priority: 4
    end
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :first_name
    column :last_name
    column :email
    column :address
    column :created_at, align: :center
    column :updated_at, align: :center
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |customer|
    text_field :first_name
    text_field :last_name
    text_field :email
    text_field :address
  end

  # collection do
  #   if current_user.admin?
  #     Customer.all
  #   elsif current_user.seller?
  #     Customer.joins(:orders).where(orders: { id: OrderItem.where(id: current_user.products.select(:id)).select(:order_id) }).distinct
  #     end
  # end

  before_action do
    unless current_user.admin?
      redirect_to root_path, alert: "You have been redirected to the home page."
    end
  end

  # before_action only: :import do
  #   unless current_user.admin?
  #     flash[:error] = "Administrator access required."
  #     redirect_to Trestle.config.path
  #   end
  # end

  # authorization do
  #   # Allow sellers to only see their products
  #   false
  # end
   

  # params do |params|
  #   params.require(:customer).permit(:name, ...)
  # end
end
