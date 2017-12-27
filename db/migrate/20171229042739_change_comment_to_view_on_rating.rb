class ChangeCommentToViewOnRating < ActiveRecord::Migration[5.1]
  def change
    rename_column :ratings, :comment, :review
  end
end
