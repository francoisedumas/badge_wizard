# frozen_string_literal: true

class GeneratedImage < ApplicationRecord
  belongs_to :prompt
  has_one_attached :image do |a|
    a.variant :thumb, resize_to_fit: [200, 200]
    a.variant :large, resize_to_fit: [1200, 1200]
  end
  delegate :description, to: :prompt
end
