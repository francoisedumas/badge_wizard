# frozen_string_literal: true

class SocialSignInButtonComponent < ViewComponent::Base
  include IconsHelper

  COLOR = {
    google: "#4285F4",
    twitter: "#1da1f2"
  }.freeze

  PATH = {
    google: "google_oauth2",
    twitter: "twitter"
  }.freeze

  def initialize(provider)
    super
    @provider = provider
    @path = Rails.application.routes.url_helpers.send("user_#{PATH[@provider]}_omniauth_authorize_path")
    @color = COLOR[provider]
  end

  def icon_class
    "bg-[#{@color}] hover:bg-[#{@color}]/90 focus:ring-[#{@color}]/50 dark:focus:ring-[#{@color}]/55"
  end
end
