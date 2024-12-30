Trestle.resource(:users) do
  menu do
    if current_user.admin?
      item :users, icon: "fa fa-star", priority: 1
    end
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

  before_action do
    unless current_user.admin?
      redirect_to root_path, alert: "You have been redirected to the home page."
    end
  end

  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
