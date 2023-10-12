# frozen_string_literal: true

# == Schema Information
#
# Table name: generated_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :bigint           not null
#
# Indexes
#
#  index_generated_images_on_prompt_id  (prompt_id)
#
# Foreign Keys
#
#  fk_rails_...  (prompt_id => prompts.id)
#
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
