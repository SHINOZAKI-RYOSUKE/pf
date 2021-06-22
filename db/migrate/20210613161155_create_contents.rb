class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.integer :user_id, null: false
      t.string :content_image
      t.text :description, null: false

      t.timestamps
    end
  end
end
