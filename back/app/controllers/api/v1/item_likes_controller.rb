class Api::V1::ItemLikesController < ApplicationController
  def create
    item_like = ItemLike.new(item_like_params.except(:uid))
    if item_like.save
      render status: :created, json: true
    end
  end

  def destroy
    item_like = ItemLike.find_by(user_id: params[:user_id], item_id: params[:item_id])
    item_like.destroy
    render status: 200, json: false
  end

  private
    def item_like_params
      params.permit(:user_id, :item_id)
    end
end
