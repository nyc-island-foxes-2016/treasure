class ItemsController < ApplicationController
  def index
    @items = Item.all #last(10) matches made ?
  end

  def new
    @item = Item.new
  end
end
