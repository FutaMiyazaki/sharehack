class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :like]
  def show
    render json: @user.as_json(include: [{items: {include: [:tags,
                                                           :item_likes,
                                                           :item_comments],
                                                  methods: :image_url} },
                                         :item_likes,
                                         :followings,
                                         :followers])
  end

  def like
    render json: @user.as_json(include: [{item_likes: { include: {item: {include: [:user,
                                                                                  :tags,
                                                                                  :item_likes,
                                                                                  :item_comments],
                                                                         methods: :image_url} } } },
                                         :items,
                                         :followings,
                                         :followers])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
