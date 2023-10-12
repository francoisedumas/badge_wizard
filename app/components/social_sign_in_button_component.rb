# frozen_string_literal: true

class SocialSignInButtonComponent < ViewComponent::Base
  include IconsHelper

  COLOR = {
    google: "bg-[#4285F4] hover:bg-[#4285F4]/90 focus:ring-[#4285F4]/50 dark:focus:ring-[#4285F4]/55",
    twitter: "bg-[#1da1f2] hover:bg-[#1da1f2]/90 focus:ring-[#1da1f2]/50 dark:focus:ring-[#1da1f2]/55"
  }.freeze

  def initialize(provider, path)
    super
    @provider = provider
    @path = path
    @icon_class = COLOR[@provider]
  end

  def provider_formating
    @provider.to_s.capitalize
  end
end
