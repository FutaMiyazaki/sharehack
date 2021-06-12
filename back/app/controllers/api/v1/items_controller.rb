class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.includes(:user, :item_likes)
    render json: items.as_json(include: [:user, :item_likes], methods: :image_url)
  end

  def show
    item = Item.find(params[:id])
    render json: item.as_json(include: [:user, :item_likes, item_comments: {include: :user}], methods: :image_url)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: item.as_json(only: :id)
    else
      render json: { data: item.errors }
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item.as_json(include: :user)
    else
      render json: { data: item.errors }
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :link, :price, :user_id, :image)
    end
end
