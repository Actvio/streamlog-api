class ConvertCommentsToPolymorphicCommentable < ActiveRecord::Migration[5.2]
  def change
    Comment.f