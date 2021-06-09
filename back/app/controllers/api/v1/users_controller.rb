class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :like]
  def show
    render json: @user.as_json(include: {items: {include: :item_likes, methods: :image_url} } )
  end

  def like
    render json: @user.as_json(include: {item_likes: {include: {item: {methods: :image_url} } } } )
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
