class AddDescriptionGroupcodeToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :description, :string
    add_column :groups, :group_code, :string, unique: true
  end
end
