# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SetCurrentRequestDetails
  include SetLocale
  before_action :authenticate_user!
end
