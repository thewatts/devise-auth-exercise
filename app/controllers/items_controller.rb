class ItemsController < ApplicationController
  def index
    @items = Item.all.limit(50)
  end
end
