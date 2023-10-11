# frozen_string_literal: true

class PasswordController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit
  end

  def update
    if @user.update_with_password(password_params)
      bypass_sign_in @user
      redirect_to edit_password_path, notice: t(".update_success")
    else
      render :edit, status: :unprocessable_entity, alert: t(".invalid_password")
    end
  end

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end
