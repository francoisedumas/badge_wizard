# frozen_string_literal: true

module Maintenance
  class BaseController < ApplicationController
    before_action :enforce_policy

    def index
    end

    private

    def enforce_policy
      head :forbidden unless MaintenancePolicy.role_can_access?
    end
  end
end
