class Api::V1::ItemCommentsController < ApplicationController
  def create
    return if User.find(item_comment_params[:user_id]).email != item_comment_params[:uid]

    comment = ItemComment.new(item_comment_params.except(:uid))
    if comment.save
      comments = ItemComment.where(item_id: item_comment_params[:item_id])
      render json: comments.as_json(include: :user)
    else
      render json: comment.errors
    end
  end

  def destroy
    comment = ItemComment.find(params[:id])

    return if User.find(comment.user_id).email != params[:uid]

    if comment.destroy
      comments = ItemComment.where(item_id: params[:item_id])
      render json: comments.as_json(include: :user)
    else
      render json: comment.errors
    end
  end

  private
    def item_comment_params
      params.permit(:id, :user_id, :item_id, :content, :uid)
    end
end
