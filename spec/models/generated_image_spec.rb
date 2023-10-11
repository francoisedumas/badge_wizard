# frozen_string_literal: true

require "rails_helper"

RSpec.describe GeneratedImage, type: :model do
  let(:prompt) { create(:prompt, description: "cat") }
  subject { create(:generated_image, prompt:) }

  it "create and persist a generated image" do
    expect(subject).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:prompt) }
  end

  describe "attachement" do
    it { is_expected.to have_one_attached(:image) }
  end

  it "delegates description to prompt" do
    expect(subject).to delegate_method(:description).to(:prompt)
  end
end
