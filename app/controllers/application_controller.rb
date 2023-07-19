# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SetCurrentRequestDetails
  include SetLocale
  before_action :authenticate_user!

  private

  def active_menu_link
    root_path
  end
  helper_method :active_menu_link
end
