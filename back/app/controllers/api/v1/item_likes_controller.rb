class Api::V1::ItemLikesController < ApplicationController
  def create
    like = ItemLike.new(item_like_params.except(:uid))
    if like.save
      item_likes = ItemLike.filter_by_item(params[:item_id]).select(:id, :user_id, :item_id)
      render json: item_likes.as_json
    end
  end

  def destroy
    like = ItemLike.find_by(user_id: params[:user_id], item_id: params[:item_id])
    if like.destroy
      item_likes = ItemLike.filter_by_item(params[:item_id]).select(:id, :user_id, :item_id)
      render json: item_likes.as_json
    end
  end

  private
    def item_like_params
      params.permit(:user_id, :item_id)
    end
end
