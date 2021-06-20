class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :like]
  def show
    render json: @user.as_json(include: [{items: {include: [:tags,
                                                           :item_likes,
                                                           :item_comments],
                                                  methods: :image_url} },
                                         :item_likes,
                                         {followings: {only: [:id, :name]}},
                                         {followers: {only: [:id, :name]}}],
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

  private
    def set_user
      @user = User.find(params[:id])
    end
end
