class Api::V1::TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags.as_json(only: [:id, :name])
  end

  def show
    tag = Tag.find(params[:id])
    render json: tag.as_json(include: {items: {include: [{user: {only: [:id, :name]}},
                                                         {tags: {only: [:id, :name]}},
                                                         :item_likes,
                                                         :item_comments],
                                               methods: :image_url} } )
  end

  def top_index
    tags = Tag.all.limit(20)
    render json: tags.as_json(only: [:id, :name])
  end

  def search
  end
end
