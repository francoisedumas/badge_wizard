# frozen_string_literal: true

module Navs
  class TabNavComponent < ViewComponent::Base
    renders_many :tabs, ->(title:, target:, data: {}, controllers: [], hidden: false) do
      Navs::TabComponent.new(title:, target:, data:, active: active?(target, controllers), hidden:)
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
end
