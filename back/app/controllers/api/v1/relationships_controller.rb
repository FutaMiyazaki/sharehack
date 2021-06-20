class Api::V1::RelationshipsController < ApplicationController
  before_action :set_user

  def create
    return if User.find(params[:user_id]).email != params[:uid]

    following = @current_user.follow(@other_user)
    if following.save
      render json: @other_user.as_json(include: [{followings: {only: [:id, :name]}},
                                                 {followers: {only: [:id, :name]}}],
                                       only: [:id, :name])
    end
  end

  def destroy
    return if User.find(params[:user_id]).email != params[:uid]

    following = @current_user.unfollow(@other_user)
    if following.destroy
      render json: @other_user.as_json(include: [{followings: {only: [:id, :name]}},
                                                 {followers: {only: [:id, :name]}}],
                                       only: [:id, :name])
    end
  end

  private
    def relationship_params
      params.permit(:user_id, :follow_id, :uid)
    end

    def set_user
      @current_user = User.find(params[:user_id])
      @other_user = User.find(params[:follow_id])
    end
end
