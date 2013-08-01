class AddImageSourceToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_src, :string
  end
end
