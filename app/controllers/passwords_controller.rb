# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication, only: :update

  def update
    user = current_user
    if user.update_with_password(password_params)
      sign_in user, bypass: true
      flash[:notice] = t(".update_success")
    else
      flash[:alert] = t(".invalid_password")
    end
    redirect_to edit_profile_path
  end

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
