class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = []

    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 28,
      })

      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @have_users = @item.have_users
    @want_users = @item.want_users
    @post = Post.new
    @posts = Post.where(item_id: @item.id)
  end
end