class UsersController < ApplicationController
  load_resource

  def index
    users_select = User.select(:id, :name, :email, :avatar).users_sort
    @users = users_select.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def show
    @posts = @user.posts.select(:id, :title, :content, :picture, :user_id,
      :created_at).posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @post = @user.posts.build
  end
end
