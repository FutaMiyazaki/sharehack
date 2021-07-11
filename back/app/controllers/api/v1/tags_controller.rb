class Api::V1::TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags.as_json(only: [:id, :name])
  end

  def show
    tag = Tag.find(params[:id])
    if params[:page]
      items = tag.items.page(params[:page]).per(12)
      render json: items.as_json(include: [{user: {only: [:id, :name],
                                                   methods: :avatar_url}},
                                           {tags: {only: [:id, :name]}},
                                           {item_likes: {only: :id}},
                                           {item_comments: {only: :id}}],
                                 methods: :image_url)
    else
      render json: tag.as_json(include: {items: {only: :id}},
                               only: [:id, :name])
    end
  end

  def top
    tags = Tag.all.limit(12)
    render json: tags.as_json(only: [:id, :name])
  end

  def search
    if params[:keyword]
      tags = Tag.search(params[:keyword])
      render json: tags.as_json(only: [:id, :name])
    end
  end

  def ranking
    tag = Tag.find(params[:id])
    items = tag.items.includes(:item_likes).sort {|a,b| b.item_likes.size <=> a.item_likes.size}
    @items = Kaminari.paginate_array(items).page(params[:page]).per(12)
    render json: @items.as_json(include: [{user: {only: [:id, :name],
                                                  methods: :avatar_url}},
                                          {tags: {only: [:id, :name]}},
                                          {item_likes: {only: :id}},
                                          {item_comments: {only: :id}}],
                                methods: :image_url)
  end
end
