class CreateGeneratedImages < ActiveRecord::Migration[7.0]
  def change
    create_table :generated_images do |t|
      t.references :prompt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
