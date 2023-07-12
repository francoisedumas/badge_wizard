# frozen_string_literal: true

class Prompt < ApplicationRecord
  belongs_to :user
  has_many :generated_images, dependent: :destroy

  validates :description, presence: true
end
