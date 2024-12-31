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
    # hidden_field :user_id, value: current_user.id
    hidden_field :user, value: current_user
  end

    # Add this to filter products
    collection do
      if current_user.admin?
        Product.all
      elsif current_user.seller?
        Product.where(user_id: current_user.id)
      end
    end

    # Set the user before creating the product
    # controller do
    #   def build_instance(params = {}, *args)
    #     instance = super
    #     instance.user = current_user
    #     instance
    #   end
    # end

    before_action do
      unless current_user.admin? || current_user.seller?
        redirect_to root_path, alert: "You have been redirected to the home page."
      end
    end

  params do |params|
    params.require(:product).permit(:title, :price, :stock, :discount)
  end
end
