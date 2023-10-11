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
class GeneratedImage < ApplicationRecord
  belongs_to :prompt
  has_one_attached :image do |a|
    a.variant :thumb, resize_to_fit: [200, 200]
    a.variant :large, resize_to_fit: [1200, 1200]
  end
  delegate :description, to: :prompt
end
