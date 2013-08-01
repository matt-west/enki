class AddImageSourceNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_src_name, :string
  end
end
