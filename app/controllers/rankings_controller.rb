class RankingsController < ApplicationController
  def have
    #[item_id => Haveの数]
    @ranking_counts = Have.ranking
    @items = Item.find(@ranking_counts.keys)
  end
  
  def want
    @ranking_counts = Want.ranking
    @items = Item.find(@ranking_counts.keys)
  end
end
