class Public::CampFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @camp = Camp.find(params[:camp_id])
    camp_favorite = current_customer.camp_favorites.new(camp_id: @camp.id)
    camp_favorite.save
    # redirect_to request.referer
  end

  def destroy
    @camp = Camp.find(params[:camp_id])
    camp_favorite = current_customer.camp_favorites.find_by(camp_id: @camp.id)
    camp_favorite.destroy
    # redirect_to request.referer
  end
end
