Trestle.resource(:order_items) do
  menu do
    item :order_items, icon: "fa fa-star", priority: 3
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :order
    column :product
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
    text_field :price
    text_field :title
    text_field :discount
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:order_item).permit(:name, ...)
  # end
end
