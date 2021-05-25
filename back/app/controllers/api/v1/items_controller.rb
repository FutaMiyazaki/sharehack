class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.includes(:user)
    render json: items.as_json(include: :user)
  end

  def show
    item = Item.find(params[:id])
    render json: item.as_json(include: :user)
  end

  def create
    item = Item.new(item_params.except(:uid))
    if item.save
      render json: item.as_json(include: :user)
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
      params.require(:item).permit(:name, :description, :link, :price, :user_id)
    end
end
