# frozen_string_literal: true

require "rails_helper"

RSpec.describe PromptsController do
  subject { response }

  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user: user) }
  let(:do_request) { get(path, params: params) }
  let(:params) { {} }
  let(:generated_image) { create(:generated_image, prompt: prompt) }

  before do
    sign_in(user)
  end

  describe "#show" do
    before do
      do_request
    end

    let(:params) { { id: prompt.id } }

    it { is_expected.to have_http_status(:ok) }

    it "has the correct content type" do
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end

  describe "#new" do
    before do
      do_request
    end

    let(:path) { "/prompts/new" }

    it { is_expected.to have_http_status(:ok) }

    it "has the correct content type" do
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end

  describe "#create" do
    let(:path) { "/prompts" }

    context "with valid parameters" do
      let(:prompt_params) { { description: "cat" } }

      it "creates a new Prompt" do
        VCR.use_cassette("create_prompt") do
          expect {
            post(path, params: { prompt: prompt_params })
          }.to change(Prompt, :count).by(1)
        end
      end
    end

    context "with invalid parameters" do
      let(:prompt_params) { { description: nil } }

      it "does not create a new Prompt" do
        expect {
          post(path, params: { prompt: prompt_params })
        }.not_to change(Prompt, :count)
      end

      it "does not create any new GeneratedImages" do
        expect {
          post(path, params: { prompt: prompt_params })
        }.not_to change(GeneratedImage, :count)
      end

      it "renders the :new template with unprocessable_entity status" do
        post(path, params: { prompt: prompt_params })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
