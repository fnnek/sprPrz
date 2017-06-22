class AddForeignKeyToReports < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :user, index: true, foreign_key: true
  end
end
