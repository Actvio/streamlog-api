class ConvertCommentsToPolymorphicCommentable < ActiveRecord::Migration[5.2]
  def change
    Comment.find_each do |comment|
      comment.commentable = AudioFile.find_by(id: commen