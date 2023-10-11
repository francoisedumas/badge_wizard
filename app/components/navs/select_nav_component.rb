# frozen_string_literal: true

module Navs
  class SelectNavComponent < ViewComponent::Base
    def initialize(label:, links:)
      super
      @label = label
      @links = links.filter { |l| l[:hidden] != true }
    end

    private

    def options
      @links.map { |l| [l[:title], l[:target]] }
    end

    def selected_target
      selected_links = @links.select do |link|
        if (controllers = link[:controllers]) && controllers.present?
          controllers.any? { |controller| request.params[:controller] == controller.to_s }
        else
          request.path == link[:target]
        end
      end
      selected_links.pluck(:target)
    end
  end
end
