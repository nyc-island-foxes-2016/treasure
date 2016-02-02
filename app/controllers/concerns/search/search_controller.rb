class SearchController < ApplicationController
  def index
    @search = []
    item_search(params[:q])
    available_items = Item.available(current_user)
    binding.pry
  end

  private

  def item_search(word)
    Item.all.each do |item|
      if item.description.include?(word) || item.description.include?(word.capitalize)

        @search.push(item)
      end
    end
  end




end