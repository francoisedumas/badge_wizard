# frozen_string_literal: true

class TabsHeaderComponent < ViewComponent::Base
  attr_reader :title, :links

  def initialize(links:, title: nil)
    super
    @links = links
    @title = title
  end

  private

  def active?(target, controllers)
    if controllers.present?
      controllers.any? { |controller| params[:controller] == controller.to_s }
    else
      request.path == target
    end
  end
end
