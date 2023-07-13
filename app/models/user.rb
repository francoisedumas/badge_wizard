# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  ROLES = %i[maintainer admin default].freeze

  enumerize :role, in: ROLES, predicates: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :prompts, dependent: :destroy
  has_many :generated_images, through: :prompts

  def full_name
    "#{first_name&.capitalize} #{last_name&.upcase}".strip.presence || email.match(/^[^@]+/).to_s.capitalize
  end
end
