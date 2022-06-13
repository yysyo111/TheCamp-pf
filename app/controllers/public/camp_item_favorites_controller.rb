class Public::CampItemFavoritesController < ApplicationController

  def create
    camp_item = CampItem.find(params[:camp_item_id])
    camp_item_favorite = current_customer.camp_item_favorites.new(camp_item_id: camp_item.id)
    camp_item_favorite.save
    redirect_to request.referer
  end

  def destroy
    camp_item = CampItem.find(params[:camp_item_id])
    camp_item_favorite = current_customer.camp_item_favorites.find_by(camp_item_id: camp_item.id)
    camp_item_favorite.destroy
    redirect_to request.referer
  end
end
