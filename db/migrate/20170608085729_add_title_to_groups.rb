class AddTitleToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :title, :string
  end
end
