# frozen_string_literal: true

require "open-uri"

class GeneratedImagesController < ApplicationController
  def index
    @pagy, @generated_images = pagy(Current.user.generated_images.includes(:prompt).order(created_at: :desc), items: 6)

    render "scrollable_list" if params[:page]
  end

  def show
    @generated_image = Current.user.generated_images.includes(:prompt).find(params[:id])
  end
end
