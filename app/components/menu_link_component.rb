# frozen_string_literal: true

class MenuLinkComponent < ViewComponent::Base
  attr_reader :title, :icon, :path, :policy, :controllers

  def initialize(title:, icon:, path:, policy: true, controllers: [])
    @title = title
    @icon = icon
    @path = path
    @policy = policy
    @controllers = controllers
  end

  def render?
    policy
  end

  def active?
    if controllers.present?
      controllers.any? { |controller| params[:controller] == controller.to_s }
    else
      request.path == path
    end
  end

  def active_classes
    active? ? "bg-gray-500" : "hover:bg-gray-600 hover:bg-opacity-75"
  end
end
