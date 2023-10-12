# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string
#  preferred_language     :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("default")
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user, first_name: "Alice", last_name: " Liddell ") }

  it "create and persist a user" do
    expect(subject).to be_valid
  end

  describe "associations" do
    it { is_expected.to have_many(:prompts) }
    it { is_expected.to have_many(:generated_images).through(:prompts) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  it "expected to be valid with an email, a handle and a password, and to be able to authenticate" do
    expect(subject.active_for_authentication?).to be true
  end

  describe "attachement" do
    it { is_expected.to have_one_attached(:photo) }
  end

  it {
    should enumerize(:role).in(
      :admin,
      :maintainer,
      :default
    )
  }

  describe "#full_name" do
    it "returns the user first & last name" do
      expect(subject.full_name).to eq("Alice LIDDELL")
    end
  end
end
