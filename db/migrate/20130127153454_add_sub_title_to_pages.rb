class AddSubTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sub_title, :string
  end
end
