class CreateRefreshTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :refresh_tokens do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.string :value, null: false
      t.datetime :expires_at, precision: 6, null: false

      t.timestamps
    end

    add_index :refresh_tokens, :value, unique: true
  end
end
