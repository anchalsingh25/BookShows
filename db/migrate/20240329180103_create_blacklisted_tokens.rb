class CreateBlacklistedTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :blacklisted_tokens do |t|
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
