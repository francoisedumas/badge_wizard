# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t("update_done")
      redirect_to edit_profile_path
    else
      flash[:alert] = t("update_error")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :preferred_language)
  end

  def set_user
    @user = current_user
  end
end
