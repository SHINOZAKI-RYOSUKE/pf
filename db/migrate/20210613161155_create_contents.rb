class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.string :content_image
      t.text :description

      t.timestamps
    end
  end
end
