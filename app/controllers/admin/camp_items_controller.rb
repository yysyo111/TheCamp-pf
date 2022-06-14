class Admin::CampItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @camp_items = CampItem.all
  end

  def show
    @camp_item = CampItem.find(params[:id])
    @camp_item_comment = CampItemComment.new
  end
end
