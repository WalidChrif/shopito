Trestle.resource(:users, model: User, scope: Auth) do
  menu do
    if current_user.admin?
      group :configuration, priority: :last do
        item :users, icon: "fas fa-users"
      end
    end
  end

  table do
    column :avatar, header: false do |user|
      avatar_for(user)
    end
    column :email, link: true
    column :first_name
    column :last_name
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |user|
    text_field :email
    text_field :first_name
    text_field :last_name
    select :role, User.roles.keys.map { |role| [role.titleize, role] }

    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
  end

  # before_action do
  #   unless current_user.admin?
  #     redirect_to root_path, alert: "You have been redirected to the home page."
  #   end
  # end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    if attrs[:password].blank?
      attrs.delete(:password)
      attrs.delete(:password_confirmation) if attrs[:password_confirmation].blank?
    end

    instance.assign_attributes(attrs)
  end

  # Log the current user back in if their password was changed
  after_action on: :update do
    if instance == current_user && instance.encrypted_password_previously_changed?
      login!(instance)
    end
  end if Devise.sign_in_after_reset_password
end