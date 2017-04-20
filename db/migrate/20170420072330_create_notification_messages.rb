class CreateNotificationMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_messages do |t|
      t.string :content
      t.string :url, default: "#"
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
