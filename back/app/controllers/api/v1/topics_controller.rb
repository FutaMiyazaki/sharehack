class Api::V1::TopicsController < ApplicationController
  def show
    topic = Topic.find(params[:id])
    render json: topic.as_json(include: [{items: {include: [{user: {only: [:id, :name, :picture]}},
                                                            {tags: {only: [:id, :name]}},
                                                            {item_likes: {only: :id}},
                                                            {item_comments: {only: :id}}]}},
                                         {user: {only: [:id, :name, :picture]}}])
  end

  def index
    if params[:page]
      topics = Topic.all.page(params[:page]).per(12)
      render json: topics.as_json(include: [{user: {only: [:id, :name, :picture]}},
                                            {items: {only: :id}}])
    else
      topics = Topic.all
      render json: topics.as_json(only: :id)
    end
  end

  def create
    topic = Topic.new(topic_params.except(:uid))
    if topic.save
      render json: topic.as_json(only: :id)
    else
      render json: { data: topic.errors }
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    return if User.find(topic.user_id).email != params[:uid]
    topic.destroy
  end

  def update
    topic = Topic.find(params[:id])
    if topic.update(topic_params.except(:uid))
      render json: topic.as_json(only: :id)
    else
      render json: { data: topic.errors }
    end
  end

  def fetch
    topic = Topic.find(params[:id])
    render json: topic.as_json(only: [:id, :title, :description, :updated_at])
  end

  def ranking
    if params[:page]
      topics = Topic.includes(:items).sort {|a,b| b.items.size <=> a.items.size}
      @topics = Kaminari.paginate_array(topics).page(params[:page]).per(12)
      render json: @topics.as_json(include: [{user: {only: [:id, :name, :picture]}},
                                            {items: {only: :id}}])
    end
  end

  def search
    if params[:keyword]
      topics = Topic.search(params[:keyword])
      render json: topics.as_json(include: [{user: {only: [:id, :name, :picture]}},
                                            {items: {only: :id}}])
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :description, :user_id, :uid)
    end
end
