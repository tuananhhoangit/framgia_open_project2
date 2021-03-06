class PostsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".post_created"
    else
      @feed_items = []
      flash[:danger] = t ".fail_to_create"
    end
    redirect_back fallback_location: root_path
  end

  def show
    @comments = @post.comments
  end

  def update
    if @post.update_attributes(title: params[:title], content: params[:content])
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def post_params
    params.require(:post).permit :id, :title, :content, :created_at, :picture, :all_tags
  end
end
