# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :enforce_policy

    def index
    end

    private

    def enforce_policy
      head :forbidden unless AdminPolicy.role_can_access?
    end
  end
end
