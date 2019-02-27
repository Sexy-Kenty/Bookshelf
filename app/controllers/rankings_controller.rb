class RankingsController < ApplicationController
  def have
    @ranking_counts = Have.ranking
    @items = Item.find(@ranking_counts.keys)
  end
end
