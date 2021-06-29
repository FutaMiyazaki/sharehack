class Api::V1::ItemsController < ApplicationController
  def index
    if params[:page]
      items = Item.all.page(params[:page]).per(12)
      render json: items.as_json(include: [{user: {only: [:id, :name],
                                                   methods: :avatar_url}},
                                           {tags: {only: [:id, :name]}},
                                           {item_likes: {only: :id}},
                                           {item_comments: {only: :id}}],
                                 methods: :image_url)
    else
      items = Item.all
      render json: items.as_json(only: :id)
    end

  end

  def show
    item = Item.find(params[:id])
    render json: item.as_json(include: [{user: {include: {followers: {only: [:id, :name]}},
                                                only: [:id, :name],
                                                methods: :avatar_url}},
                                        {tags: {only: [:id, :name]}},
                                        {item_likes: {except: [:created_at, :updated_at]}},
                                        item_comments: {include: {user: {only: [:id, :name],
                                                                         methods: :avatar_url}}}],
                              methods: :image_url)
  end

  def create
    item = Item.new(item_params)
    sent_tags = item_tags_params[:tags] === nil ? [] : item_tags_params[:tags]
    tag_list = sent_tags.split(',')
    if item.save
      item.save_tags(tag_list)
      render json: item.as_json(only: :id)
    else
      render json: { data: item.errors }
    end
  end

  def update
    item = Item.find(params[:id])
    sent_tags = item_tags_params[:tags] === nil ? [] : item_tags_params[:tags]
    tag_list = sent_tags.split(',')
    if item.update(item_params)
      item.save_tags(tag_list)
      render json: item.as_json(only: :id)
    else
      render json: { data: item.errors }
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def top
    items = Item.all.limit(6)
    render json: items.as_json(include: [{user: {only: [:id, :name],
                                                 methods: :avatar_url}},
                                         {tags: {only: [:id, :name]}},
                                         {item_likes: {only: :id}},
                                         {item_comments: {only: :id}}],
                               methods: :image_url)
  end

  def search
    if params[:keyword] && params[:page]
      items = Item.search(params[:keyword]).page(params[:page]).per(12)
      render json: items.as_json(include: [{user: {only: [:id, :name]}},
                                           {tags: {only: [:id, :name]}},
                                           {item_likes: {only: :id}},
                                           {item_comments: {only: :id}}],
                                 methods: :image_url)
    elsif params[:keyword] && !params[:page]
      items = Item.search(params[:keyword])
      render json: items.as_json(only: :id)
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :link, :price, :user_id, :image)
    end

    def item_tags_params
      params.require(:item).permit(:tags)
    end
end
