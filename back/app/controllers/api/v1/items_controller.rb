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
                                        {topic: {only: [:id, :title, :description]}},
                                        {item_likes: {except: [:created_at, :updated_at]}},
                                        item_comments: {include: {user: {only: [:id, :name],
                                                                         methods: :avatar_url}}}],
                              methods: :image_url)
  end

  def create
    return if User.find(item_params[:user_id]).email != item_params[:uid]
    item = Item.new(item_params.except(:uid))
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
    return if User.find(item.user_id).email != item_params[:uid]
    sent_tags = item_tags_params[:tags] === nil ? [] : item_tags_params[:tags]
    tag_list = sent_tags.split(',')
    if item.update(item_params.except(:uid))
      item.save_tags(tag_list)
      render json: item.as_json(only: :id)
    else
      render json: { data: item.errors }
    end
  end

  def destroy
    item = Item.find(params[:id])
    return if User.find(item.user_id).email != params[:uid]
    item.destroy
  end

  def top
    items = Item.all.limit(8)
    render json: items.as_json(include: [{user: {only: [:id, :name],
                                                 methods: :avatar_url}},
                                         {tags: {only: [:id, :name]}},
                                         {item_likes: {only: :id}},
                                         {item_comments: {only: :id}}],
                               methods: :image_url)
  end

  def timeline
    user = User.find(params[:user_id])
    following = user.followings.includes(:items)
    items = []
    following.each do |f|
      f.items.each do |i|
        items.push(i)
      end
    end

    items.sort! do |a, b|
      b[:created_at] <=> a[:created_at]
    end

    if params[:page]
      @items = Kaminari.paginate_array(items).page(params[:page]).per(12)
      render json: @items.as_json(include: [{user: {only: [:id, :name],
                                                    methods: :avatar_url}},
                                            {tags: {only: [:id, :name]}},
                                            {item_likes: {only: :id}},
                                            {item_comments: {only: :id}}],
                                  methods: :image_url)
    else
      render json: items.as_json(only: :id)
    end
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

  def search_ranking
    if params[:keyword] && params[:page]
      items = Item.search(params[:keyword]).includes(:item_likes).sort {|a,b| b.item_likes.size <=> a.item_likes.size}
      @items = Kaminari.paginate_array(items).page(params[:page]).per(12)
      render json: @items.as_json(include: [{user: {only: [:id, :name]}},
                                           {tags: {only: [:id, :name]}},
                                           {item_likes: {only: :id}},
                                           {item_comments: {only: :id}}],
                                 methods: :image_url)
    end
  end

  def ranking
    if params[:page]
      items = Item.includes(:item_likes).sort {|a,b| b.item_likes.size <=> a.item_likes.size}
      @items = Kaminari.paginate_array(items).page(params[:page]).per(12)
      render json: @items.as_json(include: [{user: {only: [:id, :name],
                                                    methods: :avatar_url}},
                                            {tags: {only: [:id, :name]}},
                                            {item_likes: {only: :id}},
                                            {item_comments: {only: :id}}],
                                  methods: :image_url)
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :link, :price, :user_id, :image, :uid, :topic_id)
    end

    def item_tags_params
      params.require(:item).permit(:tags)
    end
end
