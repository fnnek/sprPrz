class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :attachment
      t.decimal :mark

      t.timestamps
    end
  end
end
