Trestle.resource(:products) do
  menu do
    item :products, icon: "fa fa-star", priority: 5
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :title
    column :price
    column :stock
    column :sales_count
    column :discount
    column :updated_at, align: :center
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |product|
    text_field :title
    text_field :price
    text_field :stock
    number_field :discount

  end

    # Add this to filter products
    collection do
        Product.where(user_id: current_user.id)
    end

    before_action do
      unless current_user.admin? || current_user.seller?
        flash[:error] = "Administrator access required."
        flash[:alert] = "Administrator access required."
        flash[:warning] = "Administrator access required."
        redirect_to root_path
      end
    end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params.require(:product).permit(:title, :price, :stock, :discount)
  end
end
