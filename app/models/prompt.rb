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
class Prompt < ApplicationRecord
  belongs_to :user
  has_many :generated_images, dependent: :destroy

  validates :description, presence: true
end
