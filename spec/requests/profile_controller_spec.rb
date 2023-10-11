# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfileController do
  subject { response }

  let(:user) { create(:user) }
  let(:do_request) { get(path, params:) }
  let(:user_params) { attributes_for(:user) }
  let(:params) { { user: user_params } }

  before do
    sign_in(user)
  end

  describe "#edit" do
    let(:path) { "/profile/edit" }

    before do
      do_request
    end

    it { is_expected.to have_http_status(:ok) }
  end

  describe "#update" do
    let(:path) { "/profile" }

    context "with invalid parameters" do
      before do
        # Stub the update method to return false
        allow_any_instance_of(User).to receive(:update).and_return(false)

        patch(path, params: { user: { invalid_param: "invalid_value" } })
      end

      it "returns unprocessable_entity status and renders edit" do
        expect(response).to have_http_status(:unprocessable_entity)
        # Alice is the empty placeholder for the first name field
        expect(response.body).to include("Alice")
      end
    end
  end
end
