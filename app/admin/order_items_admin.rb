Trestle.resource(:order_items) do
  menu do
    item :order_items, icon: "fa fa-star", priority: 3
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :order
    # column :product
    # column :order.customer
    column :title
    column :quantity
    column :price
    column :title
    column :discount
    column :updated_at, align: :center

  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |order_item|
    text_field :quantity
    text_field :price, readonly: true
    text_field :title
    text_field :discount
  end

  before_action do
    unless current_user.admin? || current_user.seller?
      redirect_to root_path, alert: "You have been redirected to the home page."

    end
  end
  collection do 
    if current_user.admin?
      OrderItem.all
    elsif current_user.seller?
      OrderItem.where(product_id: Product.where(user_id: current_user.id).select(:id)).distinct
    end
  end
  # params do |params|
  #   params.require(:order_item).permit(:name, ...)
  # end
end
