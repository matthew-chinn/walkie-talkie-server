class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
        t.string :text
        t.integer :profile_id
        t.integer :sender_id

      t.timestamps null: false
    end
  end
end
