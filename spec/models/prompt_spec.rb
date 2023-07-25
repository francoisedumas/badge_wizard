# frozen_string_literal: true

require "rails_helper"

RSpec.describe Prompt, type: :model do
  subject { create(:prompt, description: "cat") }

  it "create and persist a prompt" do
    expect(subject).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:generated_images) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :description }
  end
end
