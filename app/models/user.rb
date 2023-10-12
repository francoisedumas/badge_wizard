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
class User < ApplicationRecord
  extend Enumerize

  ROLES = %i[maintainer admin default].freeze

  enumerize :role, in: ROLES, predicates: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:google_oauth2, :twitter]

  has_one_attached :photo
  has_many :prompts, dependent: :destroy
  has_many :generated_images, through: :prompts
  has_many :authorizations, dependent: :destroy

  # Validation
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    full = "#{first_name&.strip&.capitalize} #{last_name&.strip&.upcase}"
    full.strip.presence || email.match(/^[^@]+/).to_s.capitalize
  end

  def self.from_omniauth(auth)
    # find an existing user or create a user and authorizations
    # schema of auth https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema

    # returning user
    authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid)

    return authorization.user if authorization

    # match existing user
    existing_user = find_for_database_authentication(email: auth["info"]["email"])
    if existing_user
      existing_user.add_oauth_authorization(auth).save
      return existing_user
    end

    create_new_user_from_oauth(auth)
  end

  def add_oauth_authorization(data)
    authorizations.build(
      {
        provider: data["provider"],
        uid: data["uid"],
        access_token: data["credentials"]["token"],
        access_token_secret: data["credentials"]["secret"],
        refresh_token: data["credentials"]["refresh_token"],
        expires: data["credentials"]["expires"],
        expires_at: (date_formating data["credentials"]["expires_at"]),
        email: data["info"]["email"]
      }
    )
  end

  def date_formating(time)
    return nil if time.nil?

    Time.zone.at(time)
  end

  def self.create_new_user_from_oauth(auth)
    user = User.new(
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      avatar_url: auth.info.image
    )
    user.add_oauth_authorization(auth).save
    user
  end
end
