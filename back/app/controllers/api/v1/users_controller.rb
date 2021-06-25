class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_followings, :show_followers, :like, :update_avatar]
  def show
    render json: @user.as_json(include: [{items: {include: [:tags,
                                                           :item_likes,
                                                           :item_comments],
                                                  methods: :image_url} },
                                         :item_likes,
                                         {followings: {only: [:id, :name]}},
                                         {followers: {only: [:id, :name]}}],
                               methods: :avatar_url,
                               only: [:id, :name])
  end

  def show_followings
    render json: @user.as_json(include: {followings: {only: [:id, :name],
                                         methods: :avatar_url}},
                               only: [:id, :name])
  end

  def show_followers
    render json: @user.as_json(include: {followers: {only: [:id, :name],
                                         methods: :avatar_url}},
                               only: [:id, :name])
  end

  def like
    render json: @user.as_json(include: [{item_likes: { include: {item: {include: [{user: {only: [:id, :name]}},
                                                                                   {tags: {only: [:id, :name]}},
                                                                                   :item_likes,
                                                                                   :item_comments],
                                                                         methods: :image_url} } } },
                                         {items: {only: :id}},
                                         {followings: {only: [:id, :name]}},
                                         {followers: {only: [:id, :name]}}],
                               only: [:id, :name])
  end

  def update_avatar
    # return if @user.email != params[:uid]

    if @user.update(user_params)
      render json: @user.as_json
    else
      render json: { data: @user.errors }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:avatar)
    end
end
