class AddCommentToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :student_comment, :string
    add_column :reports, :teacher_comment, :string
  end
end
