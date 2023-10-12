# frozen_string_literal: true

# == Schema Information
#
# Table name: prompts
#
#  id          :bigint           not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_prompts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
