Trestle.resource(:orders) do
  menu do
    item :orders, icon: "fa fa-star", priority: 2
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :customer_id
    column :status
    column :total_items
    column :total_price
    column :shipping_address
    column :created_at, align: :center
    column :updated_at, align: :center
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |order|
    text_field :customer_id
    select_field :status
    text_field :shipping_address
  end

  collection do
    Order.joins(:order_items).where(order_items: { title: Product.where(user_id: 3).select(:title) }).distinct
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:order).permit(:name, ...)
  # end
end
