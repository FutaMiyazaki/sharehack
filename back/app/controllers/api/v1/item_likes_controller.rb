class Api::V1::ItemLikesController < ApplicationController
  def create
    return if User.find(params[:user_id]).email != params[:uid]
    like = ItemLike.new(item_like_params.except(:uid))
    if like.save
      item_likes = ItemLike.filter_by_item(params[:item_id]).select(:id, :user_id, :item_id)
      render json: item_likes.as_json(except: [:created_at, :updated_at])
    end
  end

  def destroy
    like = ItemLike.find_by(user_id: params[:user_id], item_id: params[:item_id])

    return if User.find(like.user_id).email != params[:uid]

    if like.destroy
      item_likes = ItemLike.filter_by_item(params[:item_id]).select(:id, :user_id, :item_id)
      render json: item_likes.as_json(except: [:created_at, :updated_at])
    end
  end

  private
    def item_like_params
      params.permit(:user_id, :item_id, :uid)
    end
end
