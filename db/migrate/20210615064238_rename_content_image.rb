class RenameContentImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :contents, :content_image, :content_image_id
  end
end
