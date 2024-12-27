Trestle.resource(:customers) do
  menu do
    item :customers, icon: "fa fa-star", priority: 4
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

  collection do
    Customer.all
  end

  before_action do
    unless current_user.admin?
      flash[:error] = "Administrator access required."
      flash[:alert] = "Administrator access required."
      flash[:warning] = "Administrator access required."
      redirect_to root_path
    end
  end

  # authorization do
  #   # Allow sellers to only see their products
  #   false
  # end
   

  # params do |params|
  #   params.require(:customer).permit(:name, ...)
  # end
end
