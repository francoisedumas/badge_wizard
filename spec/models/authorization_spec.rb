# frozen_string_literal: true

# == Schema Information
#
# Table name: authorizations
#
#  id                  :bigint           not null, primary key
#  access_token        :string
#  access_token_secret :string
#  email               :string
#  expires             :boolean          default(TRUE), not null
#  expires_at          :datetime
#  provider            :string
#  refresh_token       :string
#  uid                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_authorizations_on_uid_and_provider  (uid,provider) UNIQUE
#  index_authorizations_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Authorization, type: :model do
  let(:user) { create(:user) }
  it "is valid with a unique combination of uid and provider" do
    authorization = Authorization.new(user: user, uid: "unique_uid", provider: "unique_provider")
    expect(authorization).to be_valid
  end

  it "is not valid with a non-unique combination of uid and provider" do
    Authorization.create(user: user, uid: "duplicate_uid", provider: "duplicate_provider")
    duplicate_authorization = Authorization.new(user: user, uid: "duplicate_uid", provider: "duplicate_provider")
    expect(duplicate_authorization).not_to be_valid
  end

  it "is valid when uid is the same, but provider is different" do
    Authorization.create(user: user, uid: "common_uid", provider: "provider1")
    authorization = Authorization.new(user: user, uid: "common_uid", provider: "provider2")
    expect(authorization).to be_valid
  end
end
