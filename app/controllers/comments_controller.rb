
class CommentsController < ApplicationController
  DOES_NOT_EXIST = 'Comment does not exist'.freeze

  def index
    if params[:commentable_type].present?
      render json: Comment.where(params.permit(:commentable_type, :commentable_id))
    else
      render json: Comment.all
    end
  end

  def show
    comment = current_user.comments.find_by(id: params[:id])
    if comment.blank?
      return render json: {error: DOES_NOT_EXIST}, status: :bad_request
    end

    render json: comment
  end

  def create
    comment = current_user.comments.new(comment_params)
    if !comment.save
      render json: {error: error_msg(comment)}, status: :bad_request
      return
    end
    render json: comment
  end

  def update
    comment = current_user.comments.find_by(id: params[:id])
    if !comment.update(comment_params)
      return render json: {error: error_msg(comment)}, status: :bad_request
    end

    render json: comment
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    if comment.blank?
      return render json: {error: DOES_NOT_EXIST}, status: :bad_request
    end

    comment.destroy!
    render json: {}
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :commentable_type, :commentable_id)
  end
end