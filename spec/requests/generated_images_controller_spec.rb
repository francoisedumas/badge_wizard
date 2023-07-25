# frozen_string_literal: true

require "rails_helper"

RSpec.describe GeneratedImagesController do
  subject { response }

  let(:user) { create(:user) }
  let(:do_request) { get(path, params:) }
  let(:params) { {} }
  let(:generated_image) { create(:generated_image) }

  before do
    sign_in(user)
    do_request
  end

  describe "#index" do
    let(:path) { "/generated_images" }

    it { is_expected.to have_http_status(:ok) }

    it "has the correct content type" do
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end

  describe "#show" do
    let(:params) { { id: generated_image.id } }

    it { is_expected.to have_http_status(:ok) }

    it "has the correct content type" do
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end
end
