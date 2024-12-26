Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-star", priority: 1
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :full_name
    column :email
    column :role
    column :updated_at, align: :center
    column :created_at, align: :center
    end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    text_field :first_name
    text_field :last_name
    text_field :email
    select :role, User.roles.keys.map { |role| [role.titleize, role] }
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
