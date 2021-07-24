class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_items, :show_followings, :show_followers, :like, :topic, :update_avatar]

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

  def show_items
    if params[:page]
      items = @user.items.page(params[:page]).per(12)
      render json: items.as_json(include: [{tags: {only: [:id, :name, :created_at]}},
                                           {item_likes: {only: :id}},
                                           {item_comments: {only: :id}}],
                                 methods: :image_url)
    else
      items = @user.items
      render json: items.as_json(only: :id)
    end
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

  def topic
    render json: @user.as_json(include: {topics: { include: {items: {only: :id} } } },
                               only: [:id, :name])
  end

  def update_avatar
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
