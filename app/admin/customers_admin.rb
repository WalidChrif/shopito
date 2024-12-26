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
  # authorization do
  #   # Allow sellers to only see their products
  #   false
  # end
   

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:customer).permit(:name, ...)
  # end
end
