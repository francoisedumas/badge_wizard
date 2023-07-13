# frozen_string_literal: true

require "open-uri"

class GeneratedImagesController < ApplicationController

  def index
    @generated_images = Current.user.generated_images.includes(:prompt)
  end

  def new
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.new(user_id: Current.user.id, **prompt_params)
    attached_images_to_prompt(api_search)

    if @prompt.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prompt_params
    params.require(:prompt).permit(:description)
  end

  def api_search
    search_results = Unsplash::Photo.search(prompt_params[:description])
    search_results.first(3).map { |result| result.urls.regular.split("?").first }
  end

  def attached_images_to_prompt(image_urls)
    return if image_urls.empty?

    image_urls.each_with_index do |image_url, index|
      file = URI.parse(image_url).open
      generated_image = @prompt.generated_images.build
      generated_image.image.attach(io: file, filename: "generated_image_#{index}")
    end
  end
end
