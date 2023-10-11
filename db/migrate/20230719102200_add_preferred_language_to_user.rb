class AddPreferredLanguageToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preferred_language, :string
  end
end
