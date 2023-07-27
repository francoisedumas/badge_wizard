# frozen_string_literal: true

module Navs
  class TabComponent < ViewComponent::Base
    attr_reader :title, :target, :data, :active, :hidden

    def initialize(title:, target:, data: {}, active: false, hidden: false)
      super
      @title = title
      @target = target
      @data = data
      @active = active
      @hidden = hidden
    end

    def render?
      !hidden
    end

    private

    def active?
      active
    end

    def aria_current
      "page" if active?
    end
  end
end
