# frozen_string_literal: true

class BadgesController < ApplicationController
  def new
  end

  def create
    # byebug
    sleep 3
    search_results = Unsplash::Photo.search(search_params[:prompt])
    @image = search_results.first.urls.regular
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def search_params
    params.require(:badge).permit(:prompt)
  end
end
