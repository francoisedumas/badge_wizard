class CreateAuthorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :email
      t.string :refresh_token
      t.string :access_token
      t.string :access_token_secret
      t.boolean :expires, null: false, default: true
      t.datetime :expires_at

      t.timestamps
    end

    add_index :authorizations, [:uid, :provider], unique: true
  end
end
